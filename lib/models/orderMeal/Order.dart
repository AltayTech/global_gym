import 'package:flutter/foundation.dart';

class Order {
  final int Id;
  final String FinalizedDateTime;
  final String OrderStatusTypeName;
  final String UserFullName;
  final double TotalFee;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Order({
    @required this.Id,
    @required this.FinalizedDateTime,
    @required this.OrderStatusTypeName,
    @required this.UserFullName,
    @required this.TotalFee,
  });

  Order copyWith({
    int Id,
    String FinalizedDateTime,
    String OrderStatusTypeName,
    String UserFullName,
    double TotalFee,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
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
      UserFullName: UserFullName ?? this.UserFullName,
      TotalFee: TotalFee ?? this.TotalFee,
    );
  }

  @override
  String toString() {
    return 'Order{Id: $Id, FinalizedDateTime: $FinalizedDateTime, OrderStatusTypeName: $OrderStatusTypeName, UserFullName: $UserFullName, TotalFee: $TotalFee}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          FinalizedDateTime == other.FinalizedDateTime &&
          OrderStatusTypeName == other.OrderStatusTypeName &&
          UserFullName == other.UserFullName &&
          TotalFee == other.TotalFee);

  @override
  int get hashCode =>
      Id.hashCode ^
      FinalizedDateTime.hashCode ^
      OrderStatusTypeName.hashCode ^
      UserFullName.hashCode ^
      TotalFee.hashCode;

  factory Order.fromMap(Map<String, dynamic> map) {
    return new Order(
      Id: map['Id'],
      FinalizedDateTime: map['FinalizedDateTime']!=null?map['FinalizedDateTime']:'',
      OrderStatusTypeName: map['OrderStatusTypeName']!=null?map['OrderStatusTypeName']:'',
      UserFullName: map['UserFullName']!=null?map['UserFullName']:'',
      TotalFee: map['TotalFee'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'FinalizedDateTime': this.FinalizedDateTime,
      'OrderStatusTypeName': this.OrderStatusTypeName,
      'UserFullName': this.UserFullName,
      'TotalFee': this.TotalFee,
    };
  }

//</editor-fold>

}
