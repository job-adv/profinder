import 'package:flutter/material.dart';
import 'package:profinder/models/category/category.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/category/category_list.dart';
import 'package:profinder/services/category.dart';
import 'package:profinder/services/professional.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/category.dart';
import 'package:profinder/widgets/lists/generic_horizontal_list.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';
import 'package:profinder/pages/home/widgets/post/service.dart';

import '../../models/post/service.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<CategoryEntity>> _categoriesFuture;
  late Future<List<ServiceEntity>> _servicesFuture;

  final CategoryService category = CategoryService();
  final ProfessionalService service = ProfessionalService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadServices();
  }

  Future<void> _loadCategories() async {
    _categoriesFuture = category.fetch();
  }

  Future<void> _loadServices() async {
    _servicesFuture = service.fetch();
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
            itemBuilder: (category) {
              return Category(
                iconUrl: category.icon,
                title: category.name,
                subcategories: category.subcategories,
              );
            },
          ),
          VerticalList<ServiceEntity>(
            future: _servicesFuture,
            errorMessage: "Aucun service",
            emptyText: "Aucun service",
            itemBuilder: (service) {
              return PostService(
                title: service.title ?? '',
                description: service.description ?? '',
                username: '${service.user.firstname} ${service.user.lastname}',
                job: '@${service.user.username}',
                pictureUrl: service.user.profilePic,
                available: Helpers.boolVal(service.user.available),
                pictures: service.pictures,
                firstname: service.user.firstname,
                lastname: service.user.lastname,
                userId: service.user.userId,
                serviceId: service.serviceId!,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetail(
                        serviceId: service.serviceId,
                      ),
                    ),
                  );
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
