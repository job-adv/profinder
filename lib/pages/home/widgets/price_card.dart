import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final String description;
  final String value;
  final String rate;

  const PriceCard({
    Key? key,
    required this.description,
    required this.value,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            15), // Adjust the circular border radius as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(description),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('$value DA/$rate'),
          ),
        ],
      ),
    );
  }
}
