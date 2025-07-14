class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 3000);
  static const Duration recieveTimeout = Duration(seconds: 3000);

  //For Android
  // static const String baseUrl = 'http://10.0.2.2:5500/';
  //For Mac
  static const String baseUrl = "http://localhost:4000/";

  //Auth Section
  static const String register = "api/user/register";
  static const String login = "api/user/login";

  //Product Section
  static const String allProducts = "api/product/list";

}
