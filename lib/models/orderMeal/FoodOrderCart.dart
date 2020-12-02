import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodOrder.dart';

class FoodOrderCart with ChangeNotifier {
  final String HashFoodOrderId;
  final bool IsEmptyFoodOrder;
  final int OrderStatusTypes;
  final FoodOrder FoodOrderInfo;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FoodOrderCart({
    @required this.HashFoodOrderId,
    @required this.IsEmptyFoodOrder,
    @required this.OrderStatusTypes,
    @required this.FoodOrderInfo,
  });

  FoodOrderCart copyWith({
    String HashFoodOrderId,
    bool IsEmptyFoodOrder,
    int OrderStatusTypes,
    FoodOrder FoodOrderInfo,
  }) {
    if ((HashFoodOrderId == null ||
            identical(HashFoodOrderId, this.HashFoodOrderId)) &&
        (IsEmptyFoodOrder == null ||
            identical(IsEmptyFoodOrder, this.IsEmptyFoodOrder)) &&
        (OrderStatusTypes == null ||
            identical(OrderStatusTypes, this.OrderStatusTypes)) &&
        (FoodOrderInfo == null ||
            identical(FoodOrderInfo, this.FoodOrderInfo))) {
      return this;
    }

    return new FoodOrderCart(
      HashFoodOrderId: HashFoodOrderId ?? this.HashFoodOrderId,
      IsEmptyFoodOrder: IsEmptyFoodOrder ?? this.IsEmptyFoodOrder,
      OrderStatusTypes: OrderStatusTypes ?? this.OrderStatusTypes,
      FoodOrderInfo: FoodOrderInfo ?? this.FoodOrderInfo,
    );
  }

  @override
  String toString() {
    return 'FoodOrderCart{HashFoodOrderId: $HashFoodOrderId, IsEmptyFoodOrder: $IsEmptyFoodOrder, OrderStatusTypes: $OrderStatusTypes, FoodOrderInfo: $FoodOrderInfo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodOrderCart &&
          runtimeType == other.runtimeType &&
          HashFoodOrderId == other.HashFoodOrderId &&
          IsEmptyFoodOrder == other.IsEmptyFoodOrder &&
          OrderStatusTypes == other.OrderStatusTypes &&
          FoodOrderInfo == other.FoodOrderInfo);

  @override
  int get hashCode =>
      HashFoodOrderId.hashCode ^
      IsEmptyFoodOrder.hashCode ^
      OrderStatusTypes.hashCode ^
      FoodOrderInfo.hashCode;

  factory FoodOrderCart.fromMap(Map<String, dynamic> map) {
    return new FoodOrderCart(
      HashFoodOrderId: map['HashFoodOrderId'],
      IsEmptyFoodOrder: map['IsEmptyFoodOrder'],
      OrderStatusTypes: map['OrderStatusTypes'],
      FoodOrderInfo: FoodOrder.fromMap(map['FoodOrderInfo']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'HashFoodOrderId': this.HashFoodOrderId,
      'IsEmptyFoodOrder': this.IsEmptyFoodOrder,
      'OrderStatusTypes': this.OrderStatusTypes,
      'FoodOrderInfo': this.FoodOrderInfo,
    };
  }

//</editor-fold>

}
