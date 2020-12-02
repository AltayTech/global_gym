import 'package:flutter/foundation.dart';

class SignUpResponse with ChangeNotifier {
  final String UserName;
  final String UserFullName;
  final String Token;

  SignUpResponse({
    this.UserName,
    this.UserFullName,
    this.Token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SignUpResponse(
      UserName: parsedJson['UserName'] != null ? parsedJson['UserName'] : '',
      UserFullName:
          parsedJson['UserFullName'] != null ? parsedJson['UserFullName'] : '',
      Token: parsedJson['Token'] != null ? parsedJson['Token'] : '',
    );
  }
}
