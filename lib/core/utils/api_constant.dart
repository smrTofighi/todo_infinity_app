class ApiConstant {
  ApiConstant._();
  static const String host = 'http://127.0.0.1:8000/';
  static const String getCatList = '${host}cat-list';
  static const String deleteCat ='${host}kill-cat?id=';
  static const String listOfCatTodo = '${host}cat-todos?id=';
  static String newCategory(String title, String color, String icon) {
    String url = '${host}new-cat?title=$title&color=$color&icon=$icon';
    return url;
  }
}
