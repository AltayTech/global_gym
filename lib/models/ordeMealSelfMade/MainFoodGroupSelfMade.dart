import 'package:flutter/foundation.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodGroupSelfeMade.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';

class MainFoodGroupSelfeMade {
  final bool IsSuccess;
  final String Message;
  final List<FoodGroupSelfMade> Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainFoodGroupSelfeMade({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainFoodGroupSelfeMade copyWith({
    bool IsSuccess,
    String Message,
    List<FoodGroup> Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainFoodGroupSelfeMade(
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
      (other is MainFoodGroupSelfeMade &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainFoodGroupSelfeMade.fromMap(Map<String, dynamic> map) {
    List<FoodGroupSelfMade> value = [];

    if (map['Value'] != null) {
      var nutritionList = map['Value'] as List;
      value = nutritionList.map((i) => FoodGroupSelfMade.fromMap(i)).toList();
    }

    return new MainFoodGroupSelfeMade(
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
