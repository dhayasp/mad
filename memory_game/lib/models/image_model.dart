class ImageModel {
  String imageUrl;  // URL or path to the image
  bool isRevealed;  // Whether the image is revealed or not

  // Constructor to initialize imageUrl and isRevealed
  ImageModel({required this.imageUrl, this.isRevealed = false});
}
