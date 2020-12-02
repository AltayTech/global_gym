import 'package:flutter/foundation.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/models/week_day_exercise.dart';

class MainReserve with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<Reserve> Value;

  MainReserve({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainReserve.fromJson(Map<String, dynamic> parsedJson) {
    List<Reserve> Value = [];

    if (parsedJson['Value'] != null) {
      var exercisesList = parsedJson['Value'] as List;
      Value = exercisesList.map((i) => Reserve.fromMap(i)).toList();
    }

    return MainReserve(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: Value,
    );
  }
}
