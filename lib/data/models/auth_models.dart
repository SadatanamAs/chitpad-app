// Request/response models matching the FastAPI auth endpoints

class SignUpRequest {
  final String email;
  final String password;
  final String username;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
  };
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class TokenResponse {
  final String accessToken;
  final int expiresIn;

  TokenResponse({required this.accessToken, required this.expiresIn});

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
    accessToken: json['access_token'] ?? '',
    expiresIn: json['expires_in'] ?? 3600,
  );
}
