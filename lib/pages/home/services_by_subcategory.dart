import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/models/post/service.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/post/service.dart';
import 'package:profinder/services/favorite/favorite_list.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';
import 'package:profinder/widgets/progress/loader.dart';

class ServicesByCategory extends StatefulWidget {
  final String subCategoryName;
  final int subCategoryId;

  const ServicesByCategory({
    super.key,
    required this.subCategoryName,
    required this.subCategoryId,
  });

  @override
  State<ServicesByCategory> createState() => _ServicesByCategoryState();
}

class _ServicesByCategoryState extends State<ServicesByCategory> {
  late Future<List<ServiceEntity>> _servicesFuture;
  final ProfessionalService service = ProfessionalService();
  late Future<List<Favorite>> _favoritesFuture;
  final FavoriteListService favoriteList = FavoriteListService();
  late String? currentUserId;
  Future<void> _loadServices() async {
    _servicesFuture = service.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadServices();
    _loadFavorites();
    loadUserId();
  }

  Future<void> _loadFavorites() async {
    _favoritesFuture = favoriteList.fetch();
  }

  Future<void> loadUserId() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'userId');

    setState(() {
      currentUserId = jwtToken ?? '';
    });
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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "${widget.subCategoryName}",
        dismissIcon: FluentIcons.dismiss_12_filled,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: VerticalList<ServiceEntity>(
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
                          currentUserId: currentUserId,
                          isFavorite: isFavorite,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceDetail(
                                  serviceId: service.serviceId,
                                  isFavorite: isFavorite,
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
            ),
          ],
        ),
      ),
    );
  }
}
