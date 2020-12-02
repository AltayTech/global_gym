import 'package:flutter/foundation.dart';
import 'package:global_gym/models/user_models/login_response.dart';
import 'package:global_gym/models/user_models/signup_response.dart';

class MainSignUpResponse with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final SignUpResponse Value;

  MainSignUpResponse({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainSignUpResponse.fromJson(Map<String, dynamic> parsedJson) {
    return MainSignUpResponse(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: parsedJson['Value'] != null
          ? SignUpResponse.fromJson(parsedJson['Value'])
          : SignUpResponse(),
    );
  }
}
