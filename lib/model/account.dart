class Account {
  final String username;
  final String password;
  final String authData;
  final String url;

  final bool isAuthenticated;

  Account(
      {required this.username,
      required this.password,
      required this.authData,
      required this.url,
      required this.isAuthenticated});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        username: json['username'] as String,
        password: json['password'] as String,
        authData: json['authData'] as String,
        url: json['url'] as String,
        isAuthenticated: json['isAuthenticated'] as bool);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'authData': authData,
        'url': url,
        'isAuthenticated': isAuthenticated
      };
}
