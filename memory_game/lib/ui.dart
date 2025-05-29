import 'package:flutter/material.dart';
import 'models/image_model.dart';

class ImageBox extends StatelessWidget {
  final ImageModel imageModel;
  final Function onTap;

  const ImageBox({required this.imageModel, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), // Trigger the onTap function passed to this widget
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.6)), // Subtle border for card
          borderRadius: BorderRadius.circular(12), // Rounded corners for a smooth effect
          color: imageModel.isRevealed ? Colors.white : Colors.blueAccent, // Color change when revealed
        ),
        child: Center(
          child: imageModel.isRevealed
              ? Image.asset(imageModel.imageUrl, fit: BoxFit.cover) // Display the image if revealed
              : Container( // Default appearance when the image is hidden
                  color: Colors.blueAccent,
                  child: Center(
                    child: Icon(
                      Icons.image, // Placeholder icon to show when image is hidden
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
