import 'package:flutter/foundation.dart';

class FoodCart {
  final int FoodId;
  final String FoodName;
  final String FoodPicPath;
  final double Fee;
  final int DiscountPercent;
  final double FinalPrice;
  final int Quantity;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const FoodCart({
    @required this.FoodId,
    @required this.FoodName,
    @required this.FoodPicPath,
    @required this.Fee,
    @required this.DiscountPercent,
    @required this.FinalPrice,
    @required this.Quantity,
  });

  FoodCart copyWith({
    int FoodId,
    String FoodName,
    String FoodPicPath,
    double Fee,
    int DiscountPercent,
    double FinalPrice,
    int Quantity,
  }) {
    if ((FoodId == null || identical(FoodId, this.FoodId)) &&
        (FoodName == null || identical(FoodName, this.FoodName)) &&
        (FoodPicPath == null || identical(FoodPicPath, this.FoodPicPath)) &&
        (Fee == null || identical(Fee, this.Fee)) &&
        (DiscountPercent == null ||
            identical(DiscountPercent, this.DiscountPercent)) &&
        (FinalPrice == null || identical(FinalPrice, this.FinalPrice)) &&
        (Quantity == null || identical(Quantity, this.Quantity))) {
      return this;
    }

    return new FoodCart(
      FoodId: FoodId ?? this.FoodId,
      FoodName: FoodName ?? this.FoodName,
      FoodPicPath: FoodPicPath ?? this.FoodPicPath,
      Fee: Fee ?? this.Fee,
      DiscountPercent: DiscountPercent ?? this.DiscountPercent,
      FinalPrice: FinalPrice ?? this.FinalPrice,
      Quantity: Quantity ?? this.Quantity,
    );
  }

  @override
  String toString() {
    return 'Food{FoodId: $FoodId, FoodName: $FoodName, FoodPicPath: $FoodPicPath, Fee: $Fee, DiscountPrecent: $DiscountPercent, FinalPrice: $FinalPrice, Quantity: $Quantity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodCart &&
          runtimeType == other.runtimeType &&
          FoodId == other.FoodId &&
          FoodName == other.FoodName &&
          FoodPicPath == other.FoodPicPath &&
          Fee == other.Fee &&
          DiscountPercent == other.DiscountPercent &&
          FinalPrice == other.FinalPrice &&
          Quantity == other.Quantity);

  @override
  int get hashCode =>
      FoodId.hashCode ^
      FoodName.hashCode ^
      FoodPicPath.hashCode ^
      Fee.hashCode ^
      DiscountPercent.hashCode ^
      FinalPrice.hashCode ^
      Quantity.hashCode;

  factory FoodCart.fromMap(Map<String, dynamic> map) {
    return new FoodCart(
      FoodId: map['FoodId'],
      FoodName: map['FoodName'],
      FoodPicPath: map['FoodPicPath'] != null &&map['FoodPicPath'] != '' ? map['FoodPicPath'] : '',
      Fee: map['Fee'],
      DiscountPercent: map['DiscountPercent'],
      FinalPrice: map['FinalPrice'],
      Quantity: map['Quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'FoodId': this.FoodId,
      'FoodName': this.FoodName,
      'FoodPicPath': this.FoodPicPath,
      'Fee': this.Fee,
      'DiscountPercent': this.DiscountPercent,
      'FinalPrice': this.FinalPrice,
      'Quantity': this.Quantity,
    };
  }

//</editor-fold>

}
