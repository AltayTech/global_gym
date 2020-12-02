import 'package:flutter/foundation.dart';
import 'package:global_gym/models/user_models/plan.dart';

class MainPlans with ChangeNotifier {
  final bool IsSuccess;
  final String Message;
  final List<Plan> Value;

  MainPlans({
    this.IsSuccess,
    this.Message,
    this.Value,
  });

  factory MainPlans.fromJson(Map<String, dynamic> parsedJson) {
    List<Plan> planRaw = [];

    if (parsedJson['Value'] != null) {
      var planList = parsedJson['Value'] as List;
      planRaw = new List<Plan>();
      planRaw = planList.map((i) => Plan.fromJson(i)).toList();
    }

    return MainPlans(
      IsSuccess:
          parsedJson['IsSuccess'] != null ? parsedJson['IsSuccess'] : false,
      Message: parsedJson['Message'] != null ? parsedJson['Message'] : '',
      Value: planRaw,
    );
  }
}
