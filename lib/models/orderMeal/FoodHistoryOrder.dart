import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';

class HistoryFoodCard with ChangeNotifier {
  final int Id;
  final double SubTotalAmount;
  final int FoodOrderDetailsCount;
  final List<FoodCart> FoodOrderDetails;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  HistoryFoodCard({
    @required this.Id,
    @required this.SubTotalAmount,
    @required this.FoodOrderDetailsCount,
    @required this.FoodOrderDetails,
  });

  HistoryFoodCard copyWith({
    int Id,
    int SubTotalAmount,
    int FoodOrderDetailsCount,
    List<FoodCart> FoodOrderDetails,
  }) {
    if ((Id == null ||
        identical(Id, this.Id)) &&
        (SubTotalAmount == null ||
        identical(SubTotalAmount, this.SubTotalAmount)) &&
        (FoodOrderDetailsCount == null ||
            identical(FoodOrderDetailsCount, this.FoodOrderDetailsCount)) &&
        (FoodOrderDetails == null ||
            identical(FoodOrderDetails, this.FoodOrderDetails))) {
      return this;
    }

    return new HistoryFoodCard(
      Id: Id ?? this.Id,
      SubTotalAmount: SubTotalAmount ?? this.SubTotalAmount,
      FoodOrderDetailsCount:
      FoodOrderDetailsCount ?? this.FoodOrderDetailsCount,
      FoodOrderDetails: FoodOrderDetails ?? this.FoodOrderDetails,
    );
  }

  @override
  String toString() {
    return 'FoodHistoryOrder{Id: $Id, SubTotalAmount: $SubTotalAmount, FoodOrderDetailsCount: $FoodOrderDetailsCount, FoodOrderDetails: $FoodOrderDetails}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is HistoryFoodCard &&
              runtimeType == other.runtimeType &&
              Id == other.Id &&
              SubTotalAmount == other.SubTotalAmount &&
              FoodOrderDetailsCount == other.FoodOrderDetailsCount &&
              FoodOrderDetails == other.FoodOrderDetails);

  @override
  int get hashCode =>
  Id^
      SubTotalAmount.hashCode ^
      FoodOrderDetailsCount.hashCode ^
      FoodOrderDetails.hashCode;

  factory HistoryFoodCard.fromMap(Map<String, dynamic> map) {
    List<FoodCart> foods = [];

    if(map!=null)
    {
      if (map['FoodOrderDetails'] != null) {
        var nutritionList = map['FoodOrderDetails'] as List;
        foods = nutritionList.map((i) => FoodCart.fromMap(i)).toList();
      }
      return new HistoryFoodCard(
        Id: map['Id'],
        SubTotalAmount: map['SubTotalAmount'],
        FoodOrderDetailsCount: map['FoodOrderDetailsCount'],
        FoodOrderDetails: foods,
      );
    } else return HistoryFoodCard(
      Id: 0,
      SubTotalAmount: 0.0,
      FoodOrderDetailsCount: 0,
      FoodOrderDetails: foods,
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'SubTotalAmount': this.SubTotalAmount,
      'FoodOrderDetailsCount': this.FoodOrderDetailsCount,
      'FoodOrderDetails': this.FoodOrderDetails,
    };
  }

//</editor-fold>

}
