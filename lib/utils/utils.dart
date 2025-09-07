class Utils {
  static const String baseUrl = "www.themealdb.com/api/json/v1/1/";
  static const debugTag = "[DEBUG]";

  static String baseImageSmallResolution(String url) {
    return "$url/small";
  }

  static String baseImageMediumResolution(String url) {
    return "$url/medium";
  }

  static String baseImageLargeResolution(String url) {
    return "$url/large";
  }
}