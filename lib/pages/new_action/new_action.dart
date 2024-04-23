import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/pages/new_action/new_post.dart';
import 'package:profinder/pages/new_action/new_service.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';

import '../../utils/theme_data.dart';

class NewAction extends StatefulWidget {
  const NewAction({Key? key}) : super(key: key);

  @override
  State<NewAction> createState() => _NewActionState();
}

class _NewActionState extends State<NewAction> {
  late List<bool> isSelected;
  int _selected = 0;
  bool showErrorDialog = false;

  late String? currentUserId;
  late String? userRole = '';

  Future<void> getCurrentUserRole() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? role = await secureStorage.read(key: 'role');

    userRole = role;
    print("role: $userRole");
  }

  final List<Widget> _partials = [
    NewPost(),
    NewService(),
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUserRole();
    isSelected = [true, false];
    _selected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Créer',
        dismissIcon: FluentIcons.dismiss_12_filled,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleButtons(
                    fillColor: AppTheme.primaryColor,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    isSelected: isSelected,
                    onPressed: (int index) {
                      if (userRole == 'customer') {
                        setState(() {
                          if (!showErrorDialog) {
                            showErrorDialog = true;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                content: Text(
                                    'Veuillez créer un compte professionel pour ajouter des services.'),
                                actions: [
                                  FilledAppButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: "Ok",
                                    icon: Icons.check,
                                  ),
                                ],
                              ),
                            );
                          }
                          isSelected = [true, false];
                          _selected = 0;
                        });
                      } else {
                        setState(() {
                          isSelected[0] = index == 0;
                          isSelected[1] = index == 1;
                          _selected = index;
                        });
                      }
                    },
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Demande"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Service"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _partials[_selected]
            ],
          ),
        ),
      ),
    );
  }
}
