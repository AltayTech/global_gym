import 'package:flutter/foundation.dart';
import 'package:global_gym/models/orderMeal/Order.dart';


class MainOrder with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<Order> Value;

  MainOrder({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainOrder.fromJson(Map<String, dynamic> parsedJson) {
    List<Order> Value = [];

    if (parsedJson['Value'] != null) {
      var exercisesList = parsedJson['Value'] as List;
      Value = exercisesList.map((i) => Order.fromMap(i)).toList();
    }

    return MainOrder(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: Value,
    );
  }
}
