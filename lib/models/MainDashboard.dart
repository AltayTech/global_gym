import 'package:flutter/foundation.dart';
import 'package:global_gym/models/Dashboard.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';

class MainDashboard {
  final bool IsSuccess;
  final String Message;
  final Dashboard Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainDashboard({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainDashboard copyWith({
    bool IsSuccess,
    String Message,
    FoodOrderCart Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainDashboard(
      IsSuccess: IsSuccess ?? this.IsSuccess,
      Message: Message ?? this.Message,
      Value: Value ?? this.Value,
    );
  }

  @override
  String toString() {
    return 'MainFoodCart{IsSuccess: $IsSuccess, Message: $Message, Value: $Value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainDashboard &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainDashboard.fromMap(Map<String, dynamic> map) {
    return new MainDashboard(
      IsSuccess: map['IsSuccess'],
      Message: map['Message'],
      Value: map['Value'] != null ? Dashboard.fromMap(map['Value']) : Dashboard(),
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
