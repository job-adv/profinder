import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder/models/user/user.dart';
import 'package:profinder/models/user/user_update_request.dart';
import 'package:profinder/pages/user/customer_appointements.dart';
import 'package:profinder/pages/user/professional_appointments.dart';
import 'package:profinder/pages/user/my_posts.dart';
import 'package:profinder/pages/user/my_services.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/services/user/user.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/cards/verification_badge.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/appbar/top_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:profinder/widgets/progress/loader.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late Future<UserEntity> _userFuture;
  late TabController _tabController;

  final AuthenticationService auth = AuthenticationService();

  late String? userRole = '';

  Future<void> getCurrentUserRole() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? role = await secureStorage.read(key: 'role');

    userRole = role;
    print("role: $userRole");
    setState(() {
      _tabController = TabController(
        length: userRole == 'customer' ? 2 : 4,
        vsync: this,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    getCurrentUserRole();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<UserEntity> _loadUser() async {
    try {
      final UserEntity user = await auth.fetchUserData();
      return user;
    } catch (error) {
      print('Error loading user data: $error');
      throw error;
    }
  }

  void _changeProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);

      Reference storageReference = FirebaseStorage.instance.ref().child(
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title:
                Text("Changement d'image...", style: TextStyle(fontSize: 15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      double progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      return LinearProgressIndicator(
                        value: progress,
                        color: AppTheme.primaryColor,
                      );
                    } else {
                      return SizedBox(); // Placeholder
                    }
                  },
                ),
              ],
            ),
          );
        },
      );

      try {
        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();

        UserUpdateEntity updatedData =
            UserUpdateEntity(profilePicture: downloadURL);
        await UserService().patch(updatedData);

        print('Profile picture URL updated: $downloadURL');

        Navigator.of(context).pop(); // Dismiss dialog
      } catch (error) {
        print('Error uploading image: $error');
        Navigator.of(context).pop(); // Dismiss dialog
        // Optionally show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Compte",
      ),
      body: FutureBuilder<UserEntity>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoading();
          } else if (snapshot.hasError) {
            return SnapshotErrorWidget(error: snapshot.error);
          } else if (snapshot.hasData) {
            final UserEntity user = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: Image.network(
                          user.profilePic ?? Constants.defaultAvatar,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                      GestureDetector(
                        onTap: () {
                          _changeProfilePicture();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${user.firstname} ${user.lastname}',
                        style: AppTheme.headingTextStyle,
                      ),
                      SizedBox(width: 5),
                      VerificationBadge(
                        isVerified: Helpers.boolVal(
                          user.verified,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Badge(
                    largeSize: 35,
                    smallSize: 30,
                    label: Text(
                      '@${user.username}',
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 15 // Adjust text color if needed
                          ),
                    ),
                    backgroundColor: AppTheme.inputColor,
                    padding: EdgeInsets.only(left: 10, right: 10),
                  ),
                  if (!Helpers.boolVal(user.verified) &&
                      userRole == 'professional')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vous n\'êtes pas vérifié',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  if (!Helpers.boolVal(user.verified) &&
                      userRole == 'professional')
                    SizedBox(
                      child: Center(
                        child: Text(
                          'Veuillez choisir une catégorie dans les paramétres et ajouter votre cv',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      width: 250,
                    ),
                  SizedBox(height: 20),
                  TabBar(
                    indicatorColor: AppTheme.primaryColor,
                    labelColor: AppTheme.primaryColor,
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Mes Demandes'),
                      if (userRole != 'customer') Tab(text: 'Mes Services'),
                      if (userRole != 'customer') Tab(text: 'Mes Clients'),
                      Tab(text: 'Rendez-vous'),
                    ],
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        MyPosts(),
                        if (userRole != 'customer') MyServices(),
                        if (userRole != 'customer') ProfessionalAppointments(),
                        CustomerAppointments(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data available.'));
          }
        },
      ),
    );
  }
}
