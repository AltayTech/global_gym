import 'package:flutter/foundation.dart';
import 'package:global_gym/models/nutrition.dart';

class Meal with ChangeNotifier {
  final String Time;
  final int MealId;
  final String MealName;
  final int UserDietPeriodId;
  final List<Nutrition> Nuitritions;
  final double SumOfCalories;
  final double SumOfFat;
  final double SumOfCarbs;
  final double SumOfProtein;
  final double SumOfWeight;
  final double SumOfQuantity;

  Meal({
    this.Time,
    this.MealId,
    this.MealName,
    this.UserDietPeriodId,
    this.Nuitritions,
    this.SumOfCalories,
    this.SumOfFat,
    this.SumOfCarbs,
    this.SumOfProtein,
    this.SumOfWeight,
    this.SumOfQuantity,
  });

  factory Meal.fromJson(Map<String, dynamic> parsedJson) {
    List<Nutrition> Nuitritions = [];

    if (parsedJson['Nuitritions'] != null) {
      var nutritionList = parsedJson['Nuitritions'] as List;
      Nuitritions = new List<Nutrition>();
      Nuitritions = nutritionList.map((i) => Nutrition.fromJson(i)).toList();
    }
    return Meal(
      Time: parsedJson['Time'] != null ? parsedJson['Time'] : '',
      MealId: parsedJson['MealId'] != null ? parsedJson['MealId'] : 0,
      MealName: parsedJson['MealName'] != null ? parsedJson['MealName'] : '',
      UserDietPeriodId: parsedJson['UserDietPeriodId'] != null ? parsedJson['UserDietPeriodId'] : 0,
      Nuitritions: Nuitritions,
      SumOfCalories: parsedJson['SumOfCalories'] != null ? parsedJson['SumOfCalories'] : 0.0,
      SumOfFat: parsedJson['SumOfFat'] != null ? parsedJson['SumOfFat'] : 0.0,
      SumOfCarbs: parsedJson['SumOfCarbs'] != null ? parsedJson['SumOfCarbs'] : 0.0,
      SumOfProtein: parsedJson['SumOfProtein'] != null ? parsedJson['SumOfProtein'] : 0.0,
      SumOfWeight: parsedJson['SumOfWeight'] != null ? parsedJson['SumOfWeight'] : 0.0,
      SumOfQuantity: parsedJson['SumOfQuantity'] != null ? parsedJson['SumOfQuantity'] : 0.0,
    );
  }
}
