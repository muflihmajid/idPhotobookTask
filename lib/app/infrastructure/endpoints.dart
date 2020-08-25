class Endpoints {
  String baseUrl;

  Endpoints(String baseUrl) {
    this.baseUrl = baseUrl;
  }

  String user() {
    return '/employee';
  }

  String login() {
    return '/login';
  }

}
