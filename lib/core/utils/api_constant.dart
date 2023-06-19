class ApiConstant {
  ApiConstant._();
  static const String host = 'http://127.0.0.1:8000/';
  static const String getCatList = 'cat-list';
  static const String deleteCat = 'kill-cat?id=';
  static String newCategory(String title, String color, String icon) {
    String url = 'new-cat?title=$title&color=$color&icon=$icon';
    return url;
  }
}
