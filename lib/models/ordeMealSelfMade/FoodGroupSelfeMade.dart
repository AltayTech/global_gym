import 'package:flutter/foundation.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodSelfMade.dart';
import 'package:global_gym/models/orderMeal/Food.dart';

class FoodGroupSelfMade with ChangeNotifier {
  final int Id;
  final String Name;
  final List<FoodSelfMade> SelfMadeFoods;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

   FoodGroupSelfMade({
    @required this.Id,
    @required this.Name,
    @required this.SelfMadeFoods,
  });

  FoodGroupSelfMade copyWith({
    int Id,
    String Name,
    List<FoodSelfMade> Foods,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (Name == null || identical(Name, this.Name)) &&
        (Foods == null || identical(Foods, this.SelfMadeFoods))) {
      return this;
    }

    return new FoodGroupSelfMade(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      SelfMadeFoods: Foods ?? this.SelfMadeFoods,
    );
  }

  @override
  String toString() {
    return 'FoodGroupSelfMade{Id: $Id, Name: $Name, SelfMadeFoods: $SelfMadeFoods}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodGroupSelfMade &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Name == other.Name &&
          SelfMadeFoods == other.SelfMadeFoods);

  @override
  int get hashCode => Id.hashCode ^ Name.hashCode ^ SelfMadeFoods.hashCode;

  factory FoodGroupSelfMade.fromMap(Map<String, dynamic> map) {
    List<FoodSelfMade> foods = [];

    if (map['SelfMadeFoods'] != null) {
      var nutritionList = map['SelfMadeFoods'] as List;
      foods = nutritionList.map((i) => FoodSelfMade.fromMap(i)).toList();
    }
    return new FoodGroupSelfMade(
      Id: map['Id'],
      Name: map['Name'],
      SelfMadeFoods: foods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'Name': this.Name,
      'SelfMadeFoods': this.SelfMadeFoods,
    };
  }

//</editor-fold>

}
