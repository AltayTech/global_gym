import 'package:flutter/foundation.dart';

class Reserve extends ChangeNotifier {
  final int Id;
  final int UserId;
  final String UserFullName;
  final String FromTime;
  final String ToTime;
  final String Date;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

   Reserve({
    @required this.Id,
    @required this.UserId,
    @required this.UserFullName,
    @required this.FromTime,
    @required this.ToTime,
    @required this.Date,
  });

  Reserve copyWith({
    int Id,
    int UserId,
    String UserFullName,
    String FromTime,
    String ToTime,
    String Date,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (UserId == null || identical(UserId, this.UserId)) &&
        (UserFullName == null || identical(UserFullName, this.UserFullName)) &&
        (FromTime == null || identical(FromTime, this.FromTime)) &&
        (ToTime == null || identical(ToTime, this.ToTime)) &&
        (Date == null || identical(Date, this.Date))) {
      return this;
    }

    return new Reserve(
      Id: Id ?? this.Id,
      UserId: UserId ?? this.UserId,
      UserFullName: UserFullName ?? this.UserFullName,
      FromTime: FromTime ?? this.FromTime,
      ToTime: ToTime ?? this.ToTime,
      Date: Date ?? this.Date,
    );
  }

  @override
  String toString() {
    return 'Reserve{Id: $Id, UserId: $UserId, UserFullName: $UserFullName, FromTime: $FromTime, ToTime: $ToTime, Date: $Date}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reserve &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          UserId == other.UserId &&
          UserFullName == other.UserFullName &&
          FromTime == other.FromTime &&
          ToTime == other.ToTime &&
          Date == other.Date);

  @override
  int get hashCode =>
      Id.hashCode ^ UserId.hashCode ^ UserFullName.hashCode ^ FromTime.hashCode ^ ToTime.hashCode ^ Date.hashCode;

  factory Reserve.fromMap(Map<String, dynamic> map) {
    return new Reserve(
      Id: map['Id'],
      UserId: map['UserId'],
      UserFullName: map['UserFullName'],
      FromTime: map['FromTime'],
      ToTime: map['ToTime'],
      Date: map['Date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'UserId': this.UserId,
      'UserFullName': this.UserFullName,
      'FromTime': this.FromTime,
      'ToTime': this.ToTime,
      'Date': this.Date,
    };
  }

//</editor-fold>

}
