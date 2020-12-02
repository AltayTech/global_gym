import 'package:flutter/foundation.dart';

class Plan with ChangeNotifier {
  final int Id;
  final int PlanPaymentTypeId;
  final String PlanPaymentTypeName;
  final String Name;
  final String PriceDescription;
  final double Price;

  Plan({
    this.Id,
    this.PlanPaymentTypeId,
    this.PlanPaymentTypeName,
    this.Name,
    this.PriceDescription,
    this.Price,
  });

  factory Plan.fromJson(Map<String, dynamic> parsedJson) {
    return Plan(
      Id: parsedJson['Id'] != null ? parsedJson['Id'] : 0,
      PlanPaymentTypeId: parsedJson['PlanPaymentTypeId'] != null
          ? parsedJson['PlanPaymentTypeId']
          : 0,
      PlanPaymentTypeName: parsedJson['PlanPaymentTypeName'] != null
          ? parsedJson['PlanPaymentTypeName']
          : '',
      Name: parsedJson['Name'] != null ? parsedJson['Name'] : '',
      PriceDescription: parsedJson['PriceDescription'] != null
          ? parsedJson['PriceDescription']
          : '',
      Price: parsedJson['Price'] != null ? parsedJson['Price'] : 0.0,
    );
  }
}
