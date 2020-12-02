import 'package:flutter/foundation.dart';
import 'package:global_gym/models/user_models/login_response.dart';

class MainLoginResponse with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final LoginResponse Value;

  MainLoginResponse({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainLoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return MainLoginResponse(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: parsedJson['Value'] != null
          ? LoginResponse.fromJson(parsedJson['Value'])
          : LoginResponse(),
    );
  }
}
