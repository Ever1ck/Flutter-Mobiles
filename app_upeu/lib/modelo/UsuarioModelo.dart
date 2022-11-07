class UsuarioModelo {
  String name, email, password;

  UsuarioModelo({this.name, this.email, this.password});

  factory UsuarioModelo.fromJson(Map<String, dynamic> map) {
    return UsuarioModelo(
        name: map['name'], email: map['email'], password: map['password']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}

class TokenModelo {
  bool status;
  String message, access_token, token_type, expires_at;

  TokenModelo(
      {this.status,
      this.message,
      this.access_token,
      this.token_type,
      this.expires_at});

  factory TokenModelo.fromJson(Map<String, dynamic> map) {
    return TokenModelo(
      status: map['status'] as bool,
      message: map['message'],
      access_token: map['access_token'],
      token_type: map['token_type'],
      expires_at: map['expires_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'access_token': access_token,
      'token_type': token_type,
      'expires_at': expires_at,
    };
  }
}
