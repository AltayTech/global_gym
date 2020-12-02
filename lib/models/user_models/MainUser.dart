import 'package:flutter/foundation.dart';
import 'package:global_gym/models/user_models/user.dart';

class MainUser with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final User Value;

  MainUser({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainUser.fromJson(Map<String, dynamic> parsedJson) {
    return MainUser(
      IsSuccess: parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: User.fromMap(parsedJson['Value']),
    );
  }
}
