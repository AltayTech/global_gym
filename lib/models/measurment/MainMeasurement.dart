import 'package:flutter/foundation.dart';
import 'package:global_gym/models/measurment/Measurement.dart';

class MainMeasurement {
  final bool IsSuccess;
  final String Message;
  final List<Measurement> Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainMeasurement({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainMeasurement copyWith({
    bool IsSuccess,
    String Message,
    List<Measurement> Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainMeasurement(
      IsSuccess: IsSuccess ?? this.IsSuccess,
      Message: Message ?? this.Message,
      Value: Value ?? this.Value,
    );
  }

  @override
  String toString() {
    return 'MainFoodGroup{IsSuccess: $IsSuccess, Message: $Message, Value: $Value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainMeasurement &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainMeasurement.fromMap(Map<String, dynamic> map) {
    List<Measurement> value = [];

    if (map['Value'] != null) {
      var measurementList = map['Value'] as List;

      value = measurementList.map((e) => Measurement.fromMap(e)).toList();
    }
    return new MainMeasurement(
      IsSuccess: map['IsSuccess'],
      Message: map['Message'],
      Value: value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'IsSuccess': this.IsSuccess,
      'Message': this.Message,
      'Value': this.Value,
    };
  }

//</editor-fold>

}
