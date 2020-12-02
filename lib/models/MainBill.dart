import 'package:flutter/foundation.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/models/week_day_exercise.dart';

class MainBill with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<Bill> Value;

  MainBill({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainBill.fromJson(Map<String, dynamic> parsedJson) {
    List<Bill> Value = [];

    if (parsedJson['Value'] != null) {
      var exercisesList = parsedJson['Value'] as List;
      Value = exercisesList.map((i) => Bill.fromMap(i)).toList();
    }

    return MainBill(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: Value,
    );
  }
}
