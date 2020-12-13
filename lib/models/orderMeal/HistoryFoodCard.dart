import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';

class HistoryFoodCard with ChangeNotifier {
  final int Id;
  final String HashId;
  final double SubTotalAmount;
  final int FoodOrderDetailsCount;
  final List<FoodCart> FoodOrderDetails;
  final String UserFullName;
  final String FinalizedDateTime;
  final int OrderStatusTypes;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  HistoryFoodCard({
    @required this.Id,
    @required this.SubTotalAmount,
    @required this.FoodOrderDetailsCount,
    @required this.FoodOrderDetails,
    @required this.HashId,
    @required this.FinalizedDateTime,
    @required this.OrderStatusTypes,
    @required this.UserFullName,
  });

  HistoryFoodCard copyWith({
    int Id,
    String HashId,
    double SubTotalAmount,
    int FoodOrderDetailsCount,
    List<FoodCart> FoodOrderDetails,
    String UserFullName,
    String FinalizedDateTime,
    int OrderStatusTypes,
  }) {
    if ((Id == null ||
        identical(Id, this.Id)) &&
        (SubTotalAmount == null ||
        identical(SubTotalAmount, this.SubTotalAmount)) &&
        (FoodOrderDetailsCount == null || identical(FoodOrderDetailsCount, this.FoodOrderDetailsCount)) &&
        (HashId == null || identical(HashId, this.HashId)) &&
        (UserFullName == null || identical(UserFullName, this.UserFullName)) &&
        (FinalizedDateTime == null || identical(FinalizedDateTime, this.FinalizedDateTime)) &&
        (OrderStatusTypes == null || identical(OrderStatusTypes, this.OrderStatusTypes)) &&
        (FoodOrderDetails == null || identical(FoodOrderDetails, this.FoodOrderDetails))) {
      return this;
    }

    return new HistoryFoodCard(
      Id: Id ?? this.Id,
      SubTotalAmount: SubTotalAmount ?? this.SubTotalAmount,
      FoodOrderDetailsCount: FoodOrderDetailsCount ?? this.FoodOrderDetailsCount,
      FoodOrderDetails: FoodOrderDetails ?? this.FoodOrderDetails,
      HashId: HashId ?? this.HashId,
      FinalizedDateTime: FinalizedDateTime ?? this.FinalizedDateTime,
      OrderStatusTypes: OrderStatusTypes ?? this.OrderStatusTypes,
      UserFullName: UserFullName ?? this.UserFullName,
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
        HashId: map['HashId'],
        FinalizedDateTime: map['FinalizedDateTime'],
        UserFullName: map['UserFullName'],
        OrderStatusTypes: map['OrderStatusTypes'],
      );
    } else return HistoryFoodCard(
      Id: 0,
      SubTotalAmount: 0.0,
      FoodOrderDetailsCount: 0,
      FoodOrderDetails: foods,
      HashId: '',
      FinalizedDateTime: '',
      OrderStatusTypes: 1,
      UserFullName: ''
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'SubTotalAmount': this.SubTotalAmount,
      'FoodOrderDetailsCount': this.FoodOrderDetailsCount,
      'FoodOrderDetails': this.FoodOrderDetails,
      'HashId': this.HashId,
      'FinalizedDateTime': this.FinalizedDateTime,
      'UserFullName': this.UserFullName,
      'OrderStatusTypes': this.OrderStatusTypes
    };
  }

//</editor-fold>

}
