class ApiConstant {
  ApiConstant._();
  static const String host1 = 'http://10.0.2.2:8000/api/';
  static const String host = 'http://localhost:8000/api/';
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

  static String categoriShowApi(String id) {
    String url = '${host}category/$id';
    return url;
  }

  static String todoAddApi(String subject, String description, String prioty,
      String category, String dueDate, String status) {
    String url =
        '${host}todos?subject=$subject&description=$description&priority=$prioty&category=$category&dueDate=$dueDate&status=$status';
    return url;
  }

  static String todoDeleteApi(String id) {
    String url = '${host}todos/$id';
    return url;
  }

  static const String deleteCat = '${host}kill-cat?id=';
  static const String listOfCatTodo = '${host}cat-todos?id=';
}
