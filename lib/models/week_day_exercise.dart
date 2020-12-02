import 'package:flutter/foundation.dart';
import 'package:global_gym/models/exercise.dart';

class WeekDayExercises with ChangeNotifier {
  final int WeekDayId;
  final String WeekDayName;
  final int UserTraningPeriodId;
  final List<Exercise> UserTraningProgramExercises;
  final int SumOfReps;
  final int SumOfBreaks;
  final int SumOfTempo;
  final int SumOfSets;

  WeekDayExercises({
    this.WeekDayId,
    this.WeekDayName,
    this.UserTraningPeriodId,
    this.UserTraningProgramExercises,
    this.SumOfReps,
    this.SumOfBreaks,
    this.SumOfTempo,
    this.SumOfSets,
  });

  factory WeekDayExercises.fromJson(Map<String, dynamic> parsedJson) {
    List<Exercise> UserTraningProgramExercises = [];

    if (parsedJson['UserTraningProgramExercises'] != null) {
      var exercisesList = parsedJson['UserTraningProgramExercises'] as List;
      UserTraningProgramExercises = new List<Exercise>();
      UserTraningProgramExercises =
          exercisesList.map((i) => Exercise.fromJson(i)).toList();
    }
    return WeekDayExercises(
      WeekDayId: parsedJson['WeekDayId'] != null ? parsedJson['WeekDayId'] : 0,
      WeekDayName:
          parsedJson['WeekDayName'] != null ? parsedJson['WeekDayName'] : '',
      UserTraningPeriodId: parsedJson['UserTraningPeriodId'] != null
          ? parsedJson['UserTraningPeriodId']
          : 0,
      UserTraningProgramExercises: UserTraningProgramExercises,
      SumOfReps: parsedJson['SumOfReps'] != null ? parsedJson['SumOfReps'] : 0,
      SumOfBreaks:
          parsedJson['SumOfBreaks'] != null ? parsedJson['SumOfBreaks'] : 0,
      SumOfTempo:
          parsedJson['SumOfTempo'] != null ? parsedJson['SumOfTempo'] : 0,
      SumOfSets: parsedJson['SumOfSets'] != null ? parsedJson['SumOfSets'] : 0,
    );
  }
}
