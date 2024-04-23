import 'package:flutter/material.dart';

class FullScreenPreview extends StatelessWidget {
  final String imageUrl;

  const FullScreenPreview({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Set background color to black for full-screen effect
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        iconTheme:
            IconThemeData(color: Colors.white), // Set icon color to white
        elevation: 0, // Remove app bar elevation
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20), // Add margin to the boundary
          minScale: 0.1, // Set minimum scale
          maxScale: 4.0, // Set maximum scale
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain, // Fit the image to the viewport
          ),
        ),
      ),
    );
  }
}
