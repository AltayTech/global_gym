import 'package:flutter/foundation.dart';

class Exercise with ChangeNotifier {
  final int Id;
  final int Sets;
  final int Reps;
  final int Breaks;
  final int Tempo;
  final int WeekDayId;
  final int UserTraningPeriodId;
  final int ExerciseId;
  final String ExerciseGroupName;
  final String ExerciseName;

  Exercise({
    this.Id,
    this.Sets,
    this.Reps,
    this.Breaks,
    this.Tempo,
    this.WeekDayId,
    this.UserTraningPeriodId,
    this.ExerciseId,
    this.ExerciseGroupName,
    this.ExerciseName,
  });

  factory Exercise.fromJson(Map<String, dynamic> parsedJson) {
    return Exercise(
      Id: parsedJson['Id'] != null ? parsedJson['Id'] : 0,
      Sets: parsedJson['Sets'] != null ? parsedJson['Sets'] : 0,
      Reps: parsedJson['Reps'] != null ? parsedJson['Reps'] : 0,
      Breaks: parsedJson['Breaks'] != null ? parsedJson['Breaks'] : 0,
      Tempo: parsedJson['Tempo'] != null ? parsedJson['Tempo'] : 0,
      WeekDayId: parsedJson['WeekDayId'] != null ? parsedJson['WeekDayId'] : 0,
      UserTraningPeriodId: parsedJson['UserTraningPeriodId'] != null
          ? parsedJson['UserTraningPeriodId']
          : 0,
      ExerciseId:
          parsedJson['ExerciseId'] != null ? parsedJson['ExerciseId'] : 0,
      ExerciseGroupName: parsedJson['ExerciseGroupName'] != null
          ? parsedJson['ExerciseGroupName']
          : '',
      ExerciseName:
          parsedJson['ExerciseName'] != null ? parsedJson['ExerciseName'] : '',
    );
  }
}
