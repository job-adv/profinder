import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/pages/home/posts.dart';
import 'package:profinder/pages/home/services.dart';
import 'package:profinder/pages/home/widgets/home_page_selector.dart';
import 'package:profinder/utils/theme_data.dart';
import '../../widgets/navigation/burger_menu.dart';
import '../../widgets/appbar/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? currentUserId = '';

  void getCurrentUserId() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'userId');

    currentUserId = jwtToken;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Explorer",
      ),
      body: Column(
        children: [
          HomePageSelector(
            servicesSelected: _selectedIndex == 0,
            demandesSelected: _selectedIndex == 1,
            onService: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            onPost: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                ServicesPage(userId: currentUserId),
                PostsPage(userId: currentUserId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
