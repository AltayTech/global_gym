import 'package:flutter/foundation.dart';
import 'package:global_gym/models/nutrition.dart';

class TestModel {
  final String value1;
  final Nutrition nutrition;
  final List<Nutrition> nutritionList;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const TestModel({
    @required this.value1,
    @required this.nutrition,
    @required this.nutritionList,
  });

  TestModel copyWith({
    String value1,
    Nutrition nutrition,
    List<Nutrition> nutritionList,
  }) {
    if ((value1 == null || identical(value1, this.value1)) &&
        (nutrition == null || identical(nutrition, this.nutrition)) &&
        (nutritionList == null ||
            identical(nutritionList, this.nutritionList))) {
      return this;
    }

    return new TestModel(
      value1: value1 ?? this.value1,
      nutrition: nutrition ?? this.nutrition,
      nutritionList: nutritionList ?? this.nutritionList,
    );
  }

  @override
  String toString() {
    return 'TestModel{value1: $value1, nutrition: $nutrition, nutritionList: $nutritionList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestModel &&
          runtimeType == other.runtimeType &&
          value1 == other.value1 &&
          nutrition == other.nutrition &&
          nutritionList == other.nutritionList);

  @override
  int get hashCode =>
      value1.hashCode ^ nutrition.hashCode ^ nutritionList.hashCode;

  factory TestModel.fromMap(
    Map<String, dynamic> map, {
    String keyMapper(String key),
  }) {
    keyMapper ??= (key) => key;

    return new TestModel(
      value1: map[keyMapper('value1')] as String,
      nutrition: map[keyMapper('nutrition')] as Nutrition,
      nutritionList: map[keyMapper('nutritionList')] as List<Nutrition>,
    );
  }

  Map<String, dynamic> toMap({
    String keyMapper(String key),
  }) {
    keyMapper ??= (key) => key;

// ignore: unnecessary_cast
    return {
      keyMapper('value1'): this.value1,
      keyMapper('nutrition'): this.nutrition,
      keyMapper('nutritionList'): this.nutritionList,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
