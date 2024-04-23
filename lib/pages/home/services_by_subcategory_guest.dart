import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/service.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/post/service.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class ServicesByCategoryGuest extends StatefulWidget {
  final String subCategoryName;
  final int subCategoryId;
  final String? jwtToken;
  final String? userId;

  const ServicesByCategoryGuest({
    super.key,
    required this.subCategoryName,
    required this.subCategoryId,
    this.jwtToken,
    this.userId,
  });

  @override
  State<ServicesByCategoryGuest> createState() =>
      _ServicesByCategoryGuestState();
}

class _ServicesByCategoryGuestState extends State<ServicesByCategoryGuest> {
  late Future<List<ServiceEntity>> _servicesFuture;
  final ProfessionalService service = ProfessionalService();

  Future<void> _loadServices() async {
    _servicesFuture = service.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadServices();
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
                    userId: null,
                    serviceId: service.serviceId!,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetail(
                            serviceId: service.serviceId,
                            loggedIn: false,
                          ),
                        ),
                      );
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
