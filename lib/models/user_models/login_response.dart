import 'package:flutter/foundation.dart';

class LoginResponse with ChangeNotifier {
  final String HashId;
  final String UserName;
  final int RemainingTimeToExpire;
  final int ConfirmCode;

  LoginResponse(
      {this.HashId,
      this.UserName,
      this.RemainingTimeToExpire,
      this.ConfirmCode});

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResponse(
      HashId: parsedJson['HashId']!=null?parsedJson['HashId']:'',
      UserName: parsedJson['UserName']!=null?parsedJson['UserName']:'',
      RemainingTimeToExpire: parsedJson['RemainingTimeToExpire']!=null?parsedJson['RemainingTimeToExpire']:0,
      ConfirmCode: parsedJson['ConfirmCode']!=null?parsedJson['ConfirmCode']:0,
    );
  }
}
