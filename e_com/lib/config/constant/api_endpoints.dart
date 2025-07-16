class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 3000);
  static const Duration recieveTimeout = Duration(seconds: 3000);

  //For Android
  // static const String baseUrl = 'http://10.0.2.2:5500/';
  //For Mac
  static const String baseUrl = "http://localhost:5500/";

  //Auth Section
  static const String register = "api/signup";
  static const String login = "api/signin";
  static const String getProfile = "api/profile";

  //Product Section
  static const String allProducts = "api/products";
  static const String productByID = "api/products";

  //Cart
  static const String getAllCart = "api/cart/get";
  static const String addCart = "api/cart/add";
  static const String removeCart = "api/cart/delete";


}
