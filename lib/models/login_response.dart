class LoginResponse {
  final String message;
  final String token;

  LoginResponse({required this.message, required this.token});

  // Factory method untuk membuat objek dari JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
    );
  }
}