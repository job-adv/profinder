import 'package:flutter/material.dart';
import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/services/user/user_service.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/progress/loader.dart';

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  late Future<List<ServiceDataEntity>> _services;

  final UserPostService service = UserPostService();

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    _services = service.fetchUserServices();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<ServiceDataEntity>>(
              future: _services,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppLoading();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final services = snapshot.data!;
                  print('services $services');
                  return Column(
                    children: services.map((service) {
                      return _buildServiceCard(service);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(ServiceDataEntity service) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 0.8,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: AppTheme.primaryColor,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
