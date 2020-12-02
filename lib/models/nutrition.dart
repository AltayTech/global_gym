import 'package:flutter/foundation.dart';

class Nutrition with ChangeNotifier {
  final int Id;
  final String Name;
  final double Calories;
  final double Fat;
  final double Carbs;
  final double Protein;
  final double Weight;
  final double Quantity;
  final String PicPath;

  Nutrition({
    this.Id,
    this.Name,
    this.Calories,
    this.Fat,
    this.Carbs,
    this.Protein,
    this.Weight,
    this.Quantity,
    this.PicPath,
  });

  factory Nutrition.fromJson(Map<String, dynamic> parsedJson) {
    return Nutrition(
      Id: parsedJson['Id'] != null ? parsedJson['Id'] : 0,
      Name: parsedJson['Name'] != null ? parsedJson['Name'] : '',
      Calories: parsedJson['Calories'] != null ? parsedJson['Calories'] : 0,
      Fat: parsedJson['Fat'] != null ? parsedJson['Fat'] : '',
      Carbs: parsedJson['Carbs'] != null ? parsedJson['Carbs'] : 0.0,
      Protein: parsedJson['Protein'] != null ? parsedJson['Protein'] : 0.0,
      Weight: parsedJson['Weight'] != null ? parsedJson['Weight'] : 0.0,
      Quantity: parsedJson['Quantity'] != null ? parsedJson['Quantity'] : 0.0,
      PicPath: parsedJson['PicPath'] != null ? parsedJson['PicPath'] : '',
    );
  }
}
