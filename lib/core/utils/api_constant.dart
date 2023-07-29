class ApiConstant {
  ApiConstant._();
  static const String host = 'http://127.0.0.1:8000/api/';
  static String registerApi(
      String name, String email, String password, String rePassword) {
    String url =
        '${host}register?name=$name&email=$email&password=$password&c_password=$rePassword';
    return url;
  }

  static String signInApi(String email, String password) {
    String url = '${host}login?email=$email&password=$password';
    return url;
  }

  static const String getCategoryListApi = '${host}category/';
  static String categoryAddApi(String title, String icon, String color) {
    String url = '${host}category?title=$title&icon=$icon&color=$color';
    return url;
  }

  static String categoryDeleteApi(String id) {
    String url = '${host}category/$id';
    return url;
  }

  static const String deleteCat = '${host}kill-cat?id=';
  static const String listOfCatTodo = '${host}cat-todos?id=';
}
