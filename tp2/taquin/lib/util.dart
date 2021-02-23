const int IMAGE_SIZE = 1024;

class ImageGenerator {
  static String getStaticImageURL(int value) {
    if (value == 0)
      return "https://picsum.photos/1024";
    else {
      String imageUrl = "https://picsum.photos/" + value.toString();
      return imageUrl;
    }
  }
}
