import 'package:flutter/foundation.dart';
import 'package:global_gym/models/week_day_exercise.dart';

class MainExercises with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<WeekDayExercises> Value;

  MainExercises({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainExercises.fromJson(Map<String, dynamic> parsedJson) {
    List<WeekDayExercises> Value = [];

    if (parsedJson['Value'] != null) {
      var exercisesList = parsedJson['Value'] as List;
      Value = exercisesList.map((i) => WeekDayExercises.fromJson(i)).toList();
    }

    return MainExercises(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: Value,
    );
  }
}
