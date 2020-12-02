

import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';

class MainFoodGroup{

  final bool IsSuccess;
  final String Message;
  final List<FoodGroup> Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainFoodGroup({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainFoodGroup copyWith({
    bool IsSuccess,
    String Message,
    List<FoodGroup> Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainFoodGroup(
      IsSuccess: IsSuccess ?? this.IsSuccess,
      Message: Message ?? this.Message,
      Value: Value ?? this.Value,
    );
  }

  @override
  String toString() {
    return 'MainFoodGroup{IsSuccess: $IsSuccess, Message: $Message, Value: $Value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainFoodGroup &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainFoodGroup.fromMap(Map<String, dynamic> map) {


    List<FoodGroup> value = [];

    if (map['Value'] != null) {
      var nutritionList = map['Value'] as List;
      value = nutritionList.map((i) => FoodGroup.fromMap(i)).toList();
    }


    return new MainFoodGroup(
      IsSuccess: map['IsSuccess'],
      Message: map['Message'],
      Value: value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'IsSuccess': this.IsSuccess,
      'Message': this.Message,
      'Value': this.Value,
    };
  }

//</editor-fold>

}