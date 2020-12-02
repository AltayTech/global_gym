import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';

class FoodOrder with ChangeNotifier {
  final double SubTotalAmount;
  final int FoodOrderDetailsCount;
  final List<FoodCart> FoodOrderDetails;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FoodOrder({
    @required this.SubTotalAmount,
    @required this.FoodOrderDetailsCount,
    @required this.FoodOrderDetails,
  });

  FoodOrder copyWith({
    int SubTotalAmount,
    int FoodOrderDetailsCount,
    List<FoodCart> FoodOrderDetails,
  }) {
    if ((SubTotalAmount == null ||
            identical(SubTotalAmount, this.SubTotalAmount)) &&
        (FoodOrderDetailsCount == null ||
            identical(FoodOrderDetailsCount, this.FoodOrderDetailsCount)) &&
        (FoodOrderDetails == null ||
            identical(FoodOrderDetails, this.FoodOrderDetails))) {
      return this;
    }

    return new FoodOrder(
      SubTotalAmount: SubTotalAmount ?? this.SubTotalAmount,
      FoodOrderDetailsCount:
          FoodOrderDetailsCount ?? this.FoodOrderDetailsCount,
      FoodOrderDetails: FoodOrderDetails ?? this.FoodOrderDetails,
    );
  }

  @override
  String toString() {
    return 'FoodOrder{SubTotalAmount: $SubTotalAmount, FoodOrderDetailsCount: $FoodOrderDetailsCount, FoodOrderDetails: $FoodOrderDetails}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodOrder &&
          runtimeType == other.runtimeType &&
          SubTotalAmount == other.SubTotalAmount &&
          FoodOrderDetailsCount == other.FoodOrderDetailsCount &&
          FoodOrderDetails == other.FoodOrderDetails);

  @override
  int get hashCode =>
      SubTotalAmount.hashCode ^
      FoodOrderDetailsCount.hashCode ^
      FoodOrderDetails.hashCode;

  factory FoodOrder.fromMap(Map<String, dynamic> map) {
    List<FoodCart> foods = [];

    if (map['FoodOrderDetails'] != null) {
      var nutritionList = map['FoodOrderDetails'] as List;
      foods = nutritionList.map((i) => FoodCart.fromMap(i)).toList();
    }

    return new FoodOrder(
      SubTotalAmount: map['SubTotalAmount'],
      FoodOrderDetailsCount: map['FoodOrderDetailsCount'],
      FoodOrderDetails: foods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SubTotalAmount': this.SubTotalAmount,
      'FoodOrderDetailsCount': this.FoodOrderDetailsCount,
      'FoodOrderDetails': this.FoodOrderDetails,
    };
  }

//</editor-fold>

}
