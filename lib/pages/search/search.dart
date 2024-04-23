import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/generic_search/generic_search_request.dart';
import 'package:profinder/models/generic_search/generic_search_response.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/generic_search/generic_search.dart';
import '../../utils/theme_data.dart';
import '../../widgets/inputs/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GenericSearch search = GenericSearch();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  GenericSearchResponse? response;
  List<String>? recentSearches;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  void _saveRecentSearch(String keyword) async {
    recentSearches!.insert(0, keyword);
    await _secureStorage.write(
        key: 'recentSearches', value: recentSearches!.join(','));
    setState(() {});
  }

  void _loadRecentSearches() async {
    String? storedSearches = await _secureStorage.read(key: 'recentSearches');
    setState(() {
      recentSearches = storedSearches != null && storedSearches != ''
          ? storedSearches.split(',')
          : [];
    });
  }

  void _removeRecentSearch(int index) async {
    //recentSearches!.removeAt(index);
    await _secureStorage.write(key: 'recentSearches', value: '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: SearchAppBar(
        onSubmitted: (keyword) async {
          GenericSearchRequest req = GenericSearchRequest(
            keyword: keyword,
          );
          try {
            response = await search.post(req);
            setState(() {});
            _saveRecentSearch(keyword);
          } catch (e) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Une erreur est survenue veuillez réessayer'), // Confirmation message
                  duration:
                      Duration(seconds: 2), // Adjust the duration as needed
                ),
              );
            });
          }
        },
      ),
      body: response != null
          ? DefaultTabController(
              length: 4, // Number of tabs
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: AppTheme.textColor,
                    indicatorColor: AppTheme.primaryColor,
                    tabs: [
                      Tab(text: 'Service (${response!.services.length})'),
                      Tab(text: 'Demande (${response!.posts.length})'),
                      Tab(text: 'Artisan (${response!.artisans.length})'),
                      Tab(text: 'Client (${response!.clients.length})'),
                    ],
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildServicesTab(),
                        _buildPostsTab(),
                        _buildArtisansTab(),
                        _buildClientsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : recentSearches != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Recherches récentes (${recentSearches!.length})',
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: recentSearches!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                if (recentSearches != null &&
                                    recentSearches!.isNotEmpty) {
                                  setState(() {
                                    recentSearches!.removeAt(index);
                                    _removeRecentSearch(index);
                                  });
                                }
                              },
                            ),
                            title: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(recentSearches![index])),
                            onTap: () async {
                              GenericSearchRequest req = GenericSearchRequest(
                                keyword: recentSearches![index],
                              );
                              try {
                                response = await search.post(req);
                                setState(() {});
                              } catch (e) {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Une erreur est survenue veuillez réessayer'),
                                      duration: Duration(
                                        seconds: 2,
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              : Center(child: Icon(Icons.format_list_bulleted)),
    );
  }

  Widget _buildServicesTab() {
    return ListView.builder(
      itemCount: response!.services.length,
      itemBuilder: (context, index) {
        final service = response!.services[index];
        return GestureDetector(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            service.user.profilePicture,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${service.user.firstname} ${service.user.lastname}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        service.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description: ${service.description.substring(0, 25)}...',
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Status: ${service.status}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: true,
                  firstname: service.user.firstname,
                  lastname: service.user.lastname,
                  pictureUrl: service.user.profilePicture,
                  user_id: service.user.userId,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPostsTab() {
    return ListView.builder(
      itemCount: response!.posts.length,
      itemBuilder: (context, index) {
        final post = response!.posts[index];
        return GestureDetector(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            post.profilePicture!,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post.firstname} ${post.lastname}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description: ${post.description}',
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Status: ${post.status}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: true,
                  firstname: post.firstname,
                  lastname: post.lastname,
                  pictureUrl: post.profilePicture!,
                  user_id: post.userId,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildArtisansTab() {
    return ListView.builder(
      itemCount: response!.artisans.length,
      itemBuilder: (context, index) {
        final artisan = response!.artisans[index];
        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        artisan.profilePicture,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${artisan.firstname} ${artisan.lastname}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Numéro téléphone: ${artisan.phoneNumber}',
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Addresse: ${artisan.address}',
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(
                              available: true,
                              firstname: artisan.firstname,
                              lastname: artisan.lastname,
                              pictureUrl: artisan.profilePicture,
                              user_id: artisan.userId,
                            ),
                          ),
                        );
                      },
                      icon: Icon(FluentIcons.send_16_filled),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClientsTab() {
    return ListView.builder(
      itemCount: response!.clients.length,
      itemBuilder: (context, index) {
        final client = response!.clients[index];
        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        client.profilePicture,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${client.firstname} ${client.lastname}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Numéro téléphone: ${client.phoneNumber}',
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Addresse: ${client.address}',
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(
                              available: true,
                              firstname: client.firstname,
                              lastname: client.lastname,
                              pictureUrl: client.profilePicture,
                              user_id: client.userId,
                            ),
                          ),
                        );
                      },
                      icon: Icon(FluentIcons.send_16_filled),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
