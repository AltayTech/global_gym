import 'package:flutter/foundation.dart';

class Bill {
  final int Id;
  final String RegDateTime;
  final double Price;
  final String Description;
  final int PaymentTypeId;
  final String PaymentTypeName;
  final int UserId;
  final String UserFullName;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Bill({
    @required this.Id,
    @required this.RegDateTime,
    @required this.Price,
    @required this.Description,
    @required this.PaymentTypeId,
    @required this.PaymentTypeName,
    @required this.UserId,
    @required this.UserFullName,
  });

  Bill copyWith({
    int Id,
    String RegDateTime,
    double Price,
    String Description,
    int PaymentTypeId,
    String PaymentTypeName,
    int UserId,
    String UserFullName,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (RegDateTime == null || identical(RegDateTime, this.RegDateTime)) &&
        (Price == null || identical(Price, this.Price)) &&
        (Description == null || identical(Description, this.Description)) &&
        (PaymentTypeId == null ||
            identical(PaymentTypeId, this.PaymentTypeId)) &&
        (PaymentTypeName == null ||
            identical(PaymentTypeName, this.PaymentTypeName)) &&
        (UserId == null || identical(UserId, this.UserId)) &&
        (UserFullName == null || identical(UserFullName, this.UserFullName))) {
      return this;
    }

    return new Bill(
      Id: Id ?? this.Id,
      RegDateTime: RegDateTime ?? this.RegDateTime,
      Price: Price ?? this.Price,
      Description: Description ?? this.Description,
      PaymentTypeId: PaymentTypeId ?? this.PaymentTypeId,
      PaymentTypeName: PaymentTypeName ?? this.PaymentTypeName,
      UserId: UserId ?? this.UserId,
      UserFullName: UserFullName ?? this.UserFullName,
    );
  }

  @override
  String toString() {
    return 'Bill{Id: $Id, RegDateTime: $RegDateTime, Price: $Price, Description: $Description, PaymentTypeId: $PaymentTypeId, PaymentTypeName: $PaymentTypeName, UserId: $UserId, UserFullName: $UserFullName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          RegDateTime == other.RegDateTime &&
          Price == other.Price &&
          Description == other.Description &&
          PaymentTypeId == other.PaymentTypeId &&
          PaymentTypeName == other.PaymentTypeName &&
          UserId == other.UserId &&
          UserFullName == other.UserFullName);

  @override
  int get hashCode =>
      Id.hashCode ^
      RegDateTime.hashCode ^
      Price.hashCode ^
      Description.hashCode ^
      PaymentTypeId.hashCode ^
      PaymentTypeName.hashCode ^
      UserId.hashCode ^
      UserFullName.hashCode;

  factory Bill.fromMap(Map<String, dynamic> map) {
    return new Bill(
      Id: map['Id'],
      RegDateTime: map['RegDateTime'],
      Price: map['Price'],
      Description: map['Description'],
      PaymentTypeId: map['PaymentTypeId'],
      PaymentTypeName: map['PaymentTypeName'],
      UserId: map['UserId'],
      UserFullName: map['UserFullName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'RegDateTime': this.RegDateTime,
      'Price': this.Price,
      'Description': this.Description,
      'PaymentTypeId': this.PaymentTypeId,
      'PaymentTypeName': this.PaymentTypeName,
      'UserId': this.UserId,
      'UserFullName': this.UserFullName,
    };
  }

//</editor-fold>

}
