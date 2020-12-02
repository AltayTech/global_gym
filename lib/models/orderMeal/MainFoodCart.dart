import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';

class MainFoodCart {
  final bool IsSuccess;
  final String Message;
  final FoodOrderCart Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainFoodCart({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainFoodCart copyWith({
    bool IsSuccess,
    String Message,
    FoodOrderCart Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainFoodCart(
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
      (other is MainFoodCart &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainFoodCart.fromMap(Map<String, dynamic> map) {
    return new MainFoodCart(
      IsSuccess: map['IsSuccess'],
      Message: map['Message'],
      Value: map['Value'] != null
          ? FoodOrderCart.fromMap(map['Value'])
          : FoodOrderCart(
              HashFoodOrderId: null,
              IsEmptyFoodOrder: null,
              OrderStatusTypes: null,
              FoodOrderInfo: null),
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
