import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profinder/models/user/user_creation_request.dart';
import 'package:profinder/pages/authentication/login.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/inputs/dropdown.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/buttons/text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  var _role = 'customer';

  UserCreationRequest buildRequest() {
    return UserCreationRequest(
      username: _usernameController.text,
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
      role: _role,
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Change this to match your app bar color
      statusBarIconBrightness:
          Brightness.light, // Adjust the icon color (light or dark)
    ));
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "",
        dismissIcon: FluentIcons.chevron_left_12_filled,
        color: AppTheme.primaryColor,
        buttonsColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "S'inscrire",
                  style: AppTheme.headingTextStyle,
                ),
                SizedBox(height: 20),
                RoundedDropdownButton<String>(
                  value: _role,
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                  hintText: 'Role',
                  items: [
                    DropdownMenuItem(
                      value: 'customer',
                      child: Text('Client'),
                    ),
                    DropdownMenuItem(
                      value: 'professional',
                      child: Text('Professionel'),
                    ),
                  ],
                ),
                RoundedTextField(
                  controller: _firstnameController,
                  hintText: "Nom",
                  icon: FluentIcons.person_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre nom';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _lastnameController,
                  hintText: "Prénom",
                  icon: FluentIcons.person_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre prénom';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _usernameController,
                  hintText: "Nom d'utilisateur",
                  icon: FluentIcons.number_symbol_16_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre nom d\'utilisateur';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _addressController,
                  hintText: "Adresse",
                  obscured: false,
                  icon: FluentIcons.location_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre adresse';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _emailController,
                  hintText: "Adresse email",
                  icon: FluentIcons.mail_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre adresse email';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _passwordController,
                  hintText: "Mot de passe",
                  obscured: true,
                  icon: FluentIcons.lock_closed_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller:
                      _confirmpasswordController, // Use a separate controller
                  hintText: "Confirmer mot de passe",
                  obscured: true,
                  icon: FluentIcons.lock_closed_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez confirmer votre mot de passe';
                    } else if (value != _passwordController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledAppButton(
                          icon: FluentIcons.person_add_16_filled,
                          text: "S'inscrire",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              UserCreationRequest req = buildRequest();
                              try {
                                await AuthenticationService().signup(req);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Utilisateur créé avec succès!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '$e Veuillez vérifier vos coordonnées',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("Vous avez déjà un compte?"),
                      TextAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        text: "Se connecter",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
