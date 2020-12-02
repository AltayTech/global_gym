import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/Food.dart';

class FoodGroup with ChangeNotifier{
  final int Id;
  final String Name;
  final List<Food> Foods;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

   FoodGroup({
    @required this.Id,
    @required this.Name,
    @required this.Foods,
  });

  FoodGroup copyWith({
    int Id,
    String Name,
    List<Food> Foods,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (Name == null || identical(Name, this.Name)) &&
        (Foods == null || identical(Foods, this.Foods))) {
      return this;
    }

    return new FoodGroup(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      Foods: Foods ?? this.Foods,
    );
  }

  @override
  String toString() {
    return 'FoodGroup{Id: $Id, Name: $Name, Foods: $Foods}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodGroup &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Name == other.Name &&
          Foods == other.Foods);

  @override
  int get hashCode => Id.hashCode ^ Name.hashCode ^ Foods.hashCode;

  factory FoodGroup.fromMap(Map<String, dynamic> map) {

    List<Food> foods = [];

    if (map['Foods'] != null) {
      var nutritionList = map['Foods'] as List;
      foods = nutritionList.map((i) => Food.fromMap(i)).toList();
    }

    return new FoodGroup(
      Id: map['Id'],
      Name: map['Name'],
      Foods: foods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'Name': this.Name,
      'Foods': this.Foods,
    };
  }

//</editor-fold>

}
