import 'package:flutter/foundation.dart';

class Order {
  final int Id;
  final String FinalizedDateTime;
  final String OrderStatusTypeName;
  final int OrderStatusType;
  final String UserFullName;
  final double TotalFee;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Order({
    @required this.Id,
    @required this.FinalizedDateTime,
    @required this.OrderStatusTypeName,
    @required this.OrderStatusType,
    @required this.UserFullName,
    @required this.TotalFee,
  });

  Order copyWith({
    int Id,
    String FinalizedDateTime,
    String OrderStatusTypeName,
    int OrderStatusType,
    String UserFullName,
    double TotalFee,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&(OrderStatusType == null || identical(OrderStatusType, this.OrderStatusType)) &&
        (FinalizedDateTime == null ||
            identical(FinalizedDateTime, this.FinalizedDateTime)) &&
        (OrderStatusTypeName == null ||
            identical(OrderStatusTypeName, this.OrderStatusTypeName)) &&
        (UserFullName == null || identical(UserFullName, this.UserFullName)) &&
        (TotalFee == null || identical(TotalFee, this.TotalFee))) {
      return this;
    }

    return new Order(
      Id: Id ?? this.Id,
      FinalizedDateTime: FinalizedDateTime ?? this.FinalizedDateTime,
      OrderStatusTypeName: OrderStatusTypeName ?? this.OrderStatusTypeName,
      OrderStatusType: OrderStatusType ?? this.OrderStatusType,
      UserFullName: UserFullName ?? this.UserFullName,
      TotalFee: TotalFee ?? this.TotalFee,
    );
  }

  @override
  String toString() {
    return 'Order{Id: $Id, FinalizedDateTime: $FinalizedDateTime,OrderStatusType: $OrderStatusType, OrderStatusTypeName: $OrderStatusTypeName, UserFullName: $UserFullName, TotalFee: $TotalFee}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          FinalizedDateTime == other.FinalizedDateTime &&
          OrderStatusTypeName == other.OrderStatusTypeName &&
          OrderStatusType == other.OrderStatusType &&
          UserFullName == other.UserFullName &&
          TotalFee == other.TotalFee);

  @override
  int get hashCode =>
      Id.hashCode ^
      FinalizedDateTime.hashCode ^
      OrderStatusTypeName.hashCode ^
      OrderStatusType.hashCode ^
      UserFullName.hashCode ^
      TotalFee.hashCode;

  factory Order.fromMap(Map<String, dynamic> map) {
    return new Order(
      Id: map['Id'],
      FinalizedDateTime: map['FinalizedDateTime']!=null?map['FinalizedDateTime']:'',
      OrderStatusTypeName: map['OrderStatusTypeName']!=null?map['OrderStatusTypeName']:'',
      OrderStatusType: map['OrderStatusType']!=null?map['OrderStatusType']:'',
      UserFullName: map['UserFullName']!=null?map['UserFullName']:'',
      TotalFee: map['TotalFee'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'FinalizedDateTime': this.FinalizedDateTime,
      'OrderStatusTypeName': this.OrderStatusTypeName,
      'OrderStatusType': this.OrderStatusType,
      'UserFullName': this.UserFullName,
      'TotalFee': this.TotalFee,
    };
  }

//</editor-fold>

}
