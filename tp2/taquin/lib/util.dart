class ImageGenerator {
  static String getStaticImageURL(int value) {
    if (value == 0)
      return "https://picsum.photos/1024";
    else
      return "https://picsum.photos/" + value.toString();
  }
}
