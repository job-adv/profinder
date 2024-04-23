import 'package:flutter/material.dart';
import 'package:profinder/models/category/category.dart';
import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/category/category_list.dart';
import 'package:profinder/pages/home/widgets/favorite.dart';
import 'package:profinder/services/category/category.dart';
import 'package:profinder/services/favorite/favorite.dart';
import 'package:profinder/services/favorite/favorite_list.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/category.dart';
import 'package:profinder/widgets/lists/generic_horizontal_list.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';
import 'package:profinder/pages/home/widgets/post/service.dart';
import 'package:profinder/widgets/progress/loader.dart';

import '../../models/post/service.dart';

class ServicesPage extends StatefulWidget {
  final String? userId;
  const ServicesPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<CategoryEntity>> _categoriesFuture;
  late Future<List<ServiceEntity>> _servicesFuture;
  late Future<List<Favorite>> _favoritesFuture;

  final CategoryService category = CategoryService();
  final ProfessionalService service = ProfessionalService();
  final FavoriteListService favoriteList = FavoriteListService();
  final FavoriteService favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadServices();
    _loadFavorites();
  }

  Future<void> _loadCategories() async {
    _categoriesFuture = category.fetch();
  }

  Future<void> _loadServices() async {
    _servicesFuture = service.fetch();
  }

  Future<void> _loadFavorites() async {
    _favoritesFuture = favoriteList.fetch();
  }

  Future<bool> _isServiceInFavorites(int serviceId) async {
    final List<Favorite> favorites = await _favoritesFuture;

    if (favorites.isNotEmpty) {
      final List<int> favoriteServiceIds =
          favorites.map((favorite) => favorite.service.serviceId).toList();
      return favoriteServiceIds.contains(serviceId);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catégories',
                  style: AppTheme.elementTitle,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryList(),
                      ),
                    );
                  },
                  child: Text(
                    'Voir tout',
                    style: TextStyle(
                      color: AppTheme.textColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          HorizontalList<CategoryEntity>(
            future: _categoriesFuture,
            errorMessage: "Aucune catégorie",
            emptyText: "Aucune catégorie",
            itemBuilder: (category) {
              return Category(
                iconUrl: category.icon,
                title: category.name,
                subcategories: category.subcategories,
              );
            },
          ),
          SizedBox(height: 5),
          FutureBuilder<List<Favorite>>(
            future: _favoritesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final List<Favorite>? favorites = snapshot.data;
                if (favorites != null && favorites.isNotEmpty) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              'Services Favoris',
                              style: AppTheme.elementTitle,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      HorizontalList<Favorite>(
                        future: _favoritesFuture,
                        errorMessage: "Liste des favoris vide",
                        emptyText: "Liste des favoris vide",
                        itemBuilder: (favorite) {
                          return FavoriteWidget(
                            favorite: favorite,
                            onPress: () async {
                              try {
                                await favoriteService
                                    .deleteById(favorite.favoriteId);
                                setState(() {
                                  _loadFavorites();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Supprimé des favoris'), // Confirmation message
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erreur $e'), // Error message
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox(); // Return an empty widget if there are no favorites
                }
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Services',
                  style: AppTheme.elementTitle,
                ),
              )
            ],
          ),
          VerticalList<ServiceEntity>(
            future: _servicesFuture,
            errorMessage: "Aucun service",
            emptyText: "Aucun service",
            itemBuilder: (service) {
              return FutureBuilder<bool>(
                future: _isServiceInFavorites(service.serviceId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppLoading();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    bool isFavorite = snapshot.data ?? false;
                    return PostService(
                      title: service.title ?? '',
                      description: service.description ?? '',
                      username:
                          '${service.user.firstname} ${service.user.lastname}',
                      job: '@${service.user.username}',
                      pictureUrl: service.user.profilePic,
                      available: Helpers.boolVal(service.user.available),
                      pictures: service.pictures,
                      firstname: service.user.firstname,
                      lastname: service.user.lastname,
                      userId: service.user.userId,
                      serviceId: service.serviceId!,
                      currentUserId: widget.userId,
                      isFavorite: isFavorite,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetail(
                              serviceId: service.serviceId,
                              loggedIn: true,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
