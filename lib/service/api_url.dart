class ApiUrl {
  static const String baseUrl = 'https://api.coffeeshop.com/v1';
  static const String socketUrl = 'https://socket.coffeeshop.com';

  // Auth Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';

  // Coffee Products Endpoints
  static const String coffeeList = '$baseUrl/products/coffee';
  static const String coffeeDetails = '$baseUrl/products/coffee/';
  static const String categories = '$baseUrl/products/categories';

  // Cart & Order Endpoints
  static const String cart = '$baseUrl/cart';
  static const String placeOrder = '$baseUrl/orders/create';
  static const String orderHistory = '$baseUrl/orders/history';
}
