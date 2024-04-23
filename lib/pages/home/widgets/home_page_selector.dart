import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class HomePageSelector extends StatelessWidget {
  final bool servicesSelected;
  final bool demandesSelected;
  final VoidCallback? onService;
  final VoidCallback? onPost;

  const HomePageSelector({
    Key? key,
    required this.servicesSelected,
    required this.demandesSelected,
    required this.onService,
    required this.onPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                child: TextButton(
                  onPressed: onService,
                  child: Text(
                    "Services",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: servicesSelected
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextButton(
                  onPressed: onPost,
                  child: Text(
                    "Demandes",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: demandesSelected
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
