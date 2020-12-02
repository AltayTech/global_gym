import 'package:flutter/foundation.dart';
import 'package:global_gym/models/meal.dart';

class MainMeals with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<Meal> Value;

  MainMeals({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainMeals.fromJson(Map<String, dynamic> parsedJson) {
    List<Meal> Value = [];

    if (parsedJson['Value'] != null) {
      var nutritionList = parsedJson['Value'] as List;
      Value = nutritionList.map((i) => Meal.fromJson(i)).toList();
    }

    return MainMeals(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: Value,
    );
  }
}
