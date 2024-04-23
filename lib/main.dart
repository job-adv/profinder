import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:profinder/functions/firebase_options.dart';
import 'package:profinder/providers/conversations_provider.dart';
import 'package:profinder/providers/message_provider.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/navigation/main_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => ConversationProvider()),
      ],
      child: Profinder(),
    ),
  );
}

class Profinder extends StatelessWidget {
  const Profinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: MainNavBar(),
    );
  }
}
