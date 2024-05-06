//import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/category/category.dart';
import 'package:profinder/models/user/user.dart';
import 'package:profinder/models/user/user_update_request.dart';
import 'package:profinder/services/category/category.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/services/user/user.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/inputs/dropdown.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/progress/loader.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({Key? key}) : super(key: key);

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  late Future<UserEntity> _userFuture;
  late Future<List<CategoryEntity>> _categoriesFuture;
  final CategoryService categoryService = CategoryService();

  late int _selectedCategoryId;

  late bool new_availability;

  final AuthenticationService auth = AuthenticationService();

  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _addressController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;
  late TextEditingController _tiktokController;
  late TextEditingController _phoneNumberController;

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  late String? userRole = '';

  Future<void> getUserRole() async {
    final String? role = await secureStorage.read(key: 'role');

    userRole = role;
  }

  Future<void> _loadCategories() async {
    _categoriesFuture = categoryService.fetch();
  }

  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release!);
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
      ].request();

      havePermission =
          request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      await openAppSettings();
    }

    return havePermission;
  }

  Future<void> _uploadCv() async {
    try {
      if (await storagePermission()) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );

        if (result != null) {
          //File file = File(result.files.single.path!);
        } else {}
      } else {}
    } catch (error) {
      print('Error picking file: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    getUserRole();
    _loadCategories();
  }

  Future<UserEntity> _loadUser() async {
    try {
      final UserEntity user = await auth.fetchUserData();
      new_availability = Helpers.boolVal(user.available);

      _lastNameController = TextEditingController(text: user.lastname);
      _firstNameController = TextEditingController(text: user.firstname);
      _addressController = TextEditingController(text: user.address);
      _facebookController = TextEditingController(text: user.facebookLink);
      _instagramController = TextEditingController(text: user.instagramLink);
      _tiktokController = TextEditingController(text: user.tiktokLink);
      _phoneNumberController = TextEditingController(text: user.phoneNumber);
      _selectedCategoryId = user.categoryId ?? 1;

      return user;
    } catch (error) {
      print('Error loading user data: $error');
      throw error;
    }
  }

  // Function to save changes
  Future<void> _saveChanges() async {
    try {
      UserUpdateEntity updatedUser = UserUpdateEntity(
        lastname: _lastNameController.text,
        firstname: _firstNameController.text,
        address: _addressController.text,
        facebookLink: _facebookController.text,
        instagramLink: _instagramController.text,
        tiktokLink: _tiktokController.text,
        phoneNumber: _phoneNumberController.text,
        available: Helpers.intVal(new_availability),
        //category_id: _selectedCategoryId,
      );

      await UserService().patch(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nouveaux paramétres enregistrées'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Paramétres',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserEntity>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(margin: EdgeInsets.all(15), child: AppLoading());
            } else if (snapshot.hasError) {
              return SnapshotErrorWidget(error: snapshot.error);
            } else {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                      child: Text("Détails"),
                    ),
                    RoundedTextField(
                      controller: _lastNameController,
                      hintText: "Nom",
                      icon: FluentIcons.person_12_filled,
                      enabled: false,
                    ),
                    RoundedTextField(
                      controller: _firstNameController,
                      hintText: "Prénom",
                      icon: FluentIcons.person_12_filled,
                      enabled: false,
                    ),
                    RoundedTextField(
                      controller: _addressController,
                      hintText: "Localisation",
                      icon: FluentIcons.location_12_filled,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                      child: Text("Contact"),
                    ),
                    if (userRole == 'professional')
                      RoundedTextField(
                        controller: _facebookController,
                        hintText: "Facebook",
                        icon: Icons.facebook,
                      ),
                    if (userRole == 'professional')
                      RoundedTextField(
                        controller: _instagramController,
                        hintText: "Instagram",
                        icon: Icons.camera,
                      ),
                    if (userRole == 'professional')
                      RoundedTextField(
                        controller: _tiktokController,
                        hintText: "Tiktok",
                        icon: Icons.tiktok,
                      ),
                    RoundedTextField(
                      controller: _phoneNumberController,
                      hintText: "Phone",
                      icon: FluentIcons.phone_12_filled,
                    ),
                    if (userRole == 'professional')
                      FutureBuilder<List<CategoryEntity>>(
                        future: _categoriesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return AppLoading();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            if (snapshot.data != null) {
                              print(snapshot.data);
                              return RoundedDropdownButton<String>(
                                value: _selectedCategoryId.toString(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCategoryId = int.parse(newValue!);
                                  });
                                },
                                hintText: 'Choisir une catégorie',
                                items: snapshot.data!
                                    .map<DropdownMenuItem<String>>(
                                  (CategoryEntity category) {
                                    return DropdownMenuItem<String>(
                                      value: category.id.toString(),
                                      child: Text(category.name),
                                    );
                                  },
                                ).toList(),
                              );
                            } else {
                              return Text('No subcategories available');
                            }
                          }
                        },
                      ),
                    if (userRole == 'professional')
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 5,
                          top: 10,
                        ),
                        child: FilledAppButton(
                          icon: FluentIcons.document_16_filled,
                          text: 'Ajouter/Modifier CV',
                          onPressed: _uploadCv,
                        ),
                      ),
                    if (userRole == 'professional')
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 5,
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Disponibilité"),
                            Switch(
                              value: new_availability,
                              onChanged: (newValue) {
                                setState(() {
                                  new_availability = newValue;
                                });
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: FilledAppButton(
                        icon: FluentIcons.save_16_filled,
                        text: "Enregistrer",
                        onPressed: _saveChanges,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
