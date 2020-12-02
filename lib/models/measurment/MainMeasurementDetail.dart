import 'package:flutter/foundation.dart';
import 'package:global_gym/models/measurment/Measurement.dart';

class MainMeasurementDetail {
  final bool IsSuccess;
  final String Message;
  final Measurement Value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MainMeasurementDetail({
    @required this.IsSuccess,
    @required this.Message,
    @required this.Value,
  });

  MainMeasurementDetail copyWith({
    bool IsSuccess,
    String Message,
    Measurement Value,
  }) {
    if ((IsSuccess == null || identical(IsSuccess, this.IsSuccess)) &&
        (Message == null || identical(Message, this.Message)) &&
        (Value == null || identical(Value, this.Value))) {
      return this;
    }

    return new MainMeasurementDetail(
      IsSuccess: IsSuccess ?? this.IsSuccess,
      Message: Message ?? this.Message,
      Value: Value ?? this.Value,
    );
  }

  @override
  String toString() {
    return 'MainMeasurement{IsSuccess: $IsSuccess, Message: $Message, Value: $Value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainMeasurementDetail &&
          runtimeType == other.runtimeType &&
          IsSuccess == other.IsSuccess &&
          Message == other.Message &&
          Value == other.Value);

  @override
  int get hashCode => IsSuccess.hashCode ^ Message.hashCode ^ Value.hashCode;

  factory MainMeasurementDetail.fromMap(Map<String, dynamic> map) {
    return new MainMeasurementDetail(
      IsSuccess: map['IsSuccess'],
      Message: map['Message'],
      Value: Measurement.fromMap(map['Value']),
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
