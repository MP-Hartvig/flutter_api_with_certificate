import 'dart:convert';

class Token {
  final String token;
  final String expiresIn;

  Token({
    required this.token,
    required this.expiresIn,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    String tokenString = json['token'];
    String expiresInString = json['expiresIn'];
    return Token(token: tokenString, expiresIn: expiresInString);
  }
  
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'token': token});
    result.addAll({'expiresIn': expiresIn});

    return result;
  }

  String toJson() => json.encode(toMap());
}
