import 'package:flutter/foundation.dart';

class Measurement with ChangeNotifier {
  final int Id;
  final int Height;
  final double Weight;
  final double WeightGoal;

  final String WekeUpTime;
  final String TrainTime;
  final String SleepTime;

  final int Age;
  final int ActivityLevel;
  final double Triceps;
  final double Biceps;
  final double Chest;
  final double Subscap;
  final double Midax;
  final double Suprullic;
  final double Abs;
  final double Thigh;
  final double Hamstring;
  final double Knee;
  final int UserId;
  final String ShortDate;
  final String LongDate;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

   Measurement({
    @required this.Id,
    @required this.Height,
    @required this.Weight,
    @required this.WeightGoal,
    @required this.WekeUpTime,
    @required this.TrainTime,
    @required this.SleepTime,
    @required this.Age,
    @required this.ActivityLevel,
    @required this.Triceps,
    @required this.Biceps,
    @required this.Chest,
    @required this.Subscap,
    @required this.Midax,
    @required this.Suprullic,
    @required this.Abs,
    @required this.Thigh,
    @required this.Hamstring,
    @required this.Knee,
    @required this.UserId,
    @required this.ShortDate,
    @required this.LongDate,
  });

  Measurement copyWith({
    int Id,
    int Height,
    double Weight,
    double WeightGoal,
    String WekeUpTime,
    String TrainTime,
    String SleepTime,
    int Age,
    int ActivityLevel,
    double Triceps,
    double Biceps,
    double Chest,
    double Subscap,
    double Midax,
    double Suprullic,
    double Abs,
    double Thigh,
    double Hamstring,
    double Knee,
    int UserId,
    String ShortDate,
    String LongDate,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (Height == null || identical(Height, this.Height)) &&
        (Weight == null || identical(Weight, this.Weight)) &&
        (WeightGoal == null || identical(WeightGoal, this.WeightGoal)) &&
        (WekeUpTime == null || identical(WekeUpTime, this.WekeUpTime)) &&
        (TrainTime == null || identical(TrainTime, this.TrainTime)) &&
        (SleepTime == null || identical(SleepTime, this.SleepTime)) &&
        (Age == null || identical(Age, this.Age)) &&
        (ActivityLevel == null || identical(ActivityLevel, this.ActivityLevel)) &&
        (Triceps == null || identical(Triceps, this.Triceps)) &&
        (Biceps == null || identical(Biceps, this.Biceps)) &&
        (Chest == null || identical(Chest, this.Chest)) &&
        (Subscap == null || identical(Subscap, this.Subscap)) &&
        (Midax == null || identical(Midax, this.Midax)) &&
        (Suprullic == null || identical(Suprullic, this.Suprullic)) &&
        (Abs == null || identical(Abs, this.Abs)) &&
        (Thigh == null || identical(Thigh, this.Thigh)) &&
        (Hamstring == null || identical(Hamstring, this.Hamstring)) &&
        (Knee == null || identical(Knee, this.Knee)) &&
        (UserId == null || identical(UserId, this.UserId)) &&
        (ShortDate == null || identical(ShortDate, this.ShortDate)) &&
        (LongDate == null || identical(LongDate, this.LongDate))) {
      return this;
    }

    return new Measurement(
      Id: Id ?? this.Id,
      Height: Height ?? this.Height,
      Weight: Weight ?? this.Weight,
      WeightGoal: WeightGoal ?? this.WeightGoal,
      WekeUpTime: WekeUpTime ?? this.WekeUpTime,
      TrainTime: TrainTime ?? this.TrainTime,
      SleepTime: SleepTime ?? this.SleepTime,
      Age: Age ?? this.Age,
      ActivityLevel: ActivityLevel ?? this.ActivityLevel,
      Triceps: Triceps ?? this.Triceps,
      Biceps: Biceps ?? this.Biceps,
      Chest: Chest ?? this.Chest,
      Subscap: Subscap ?? this.Subscap,
      Midax: Midax ?? this.Midax,
      Suprullic: Suprullic ?? this.Suprullic,
      Abs: Abs ?? this.Abs,
      Thigh: Thigh ?? this.Thigh,
      Hamstring: Hamstring ?? this.Hamstring,
      Knee: Knee ?? this.Knee,
      UserId: UserId ?? this.UserId,
      ShortDate: ShortDate ?? this.ShortDate,
      LongDate: LongDate ?? this.LongDate,
    );
  }

  @override
  String toString() {
    return 'Measurement{Id: $Id, Height: $Height, Weight: $Weight, WeightGoal: $WeightGoal, WekeUpTime: $WekeUpTime, TrainTime: $TrainTime, SleepTime: $SleepTime, Age: $Age, ActivityLevel: $ActivityLevel, Triceps: $Triceps, Biceps: $Biceps, Chest: $Chest, Subscap: $Subscap, Midax: $Midax, Suprullic: $Suprullic, Abs: $Abs, Thigh: $Thigh, Hamstring: $Hamstring, Knee: $Knee, UserId: $UserId, ShortDate: $ShortDate, LongDate: $LongDate}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Measurement &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Height == other.Height &&
          Weight == other.Weight &&
          WeightGoal == other.WeightGoal &&
          WekeUpTime == other.WekeUpTime &&
          TrainTime == other.TrainTime &&
          SleepTime == other.SleepTime &&
          Age == other.Age &&
          ActivityLevel == other.ActivityLevel &&
          Triceps == other.Triceps &&
          Biceps == other.Biceps &&
          Chest == other.Chest &&
          Subscap == other.Subscap &&
          Midax == other.Midax &&
          Suprullic == other.Suprullic &&
          Abs == other.Abs &&
          Thigh == other.Thigh &&
          Hamstring == other.Hamstring &&
          Knee == other.Knee &&
          UserId == other.UserId &&
          ShortDate == other.ShortDate &&
          LongDate == other.LongDate);

  @override
  int get hashCode =>
      Id.hashCode ^
      Height.hashCode ^
      Weight.hashCode ^
      WeightGoal.hashCode ^
      WekeUpTime.hashCode ^
      TrainTime.hashCode ^
      SleepTime.hashCode ^
      Age.hashCode ^
      ActivityLevel.hashCode ^
      Triceps.hashCode ^
      Biceps.hashCode ^
      Chest.hashCode ^
      Subscap.hashCode ^
      Midax.hashCode ^
      Suprullic.hashCode ^
      Abs.hashCode ^
      Thigh.hashCode ^
      Hamstring.hashCode ^
      Knee.hashCode ^
      UserId.hashCode ^
      ShortDate.hashCode ^
      LongDate.hashCode;

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return new Measurement(
      Id: map['Id'] != null ? map['Id'] : 0,
      Height: map['Height'] != null ? map['Height'] : 0,
      Weight: map['Weight'] != null ? map['Weight'] : 0.0,
      WeightGoal: map['WeightGoal'] != null ? map['WeightGoal'] : 0.0,
      WekeUpTime: map['WekeUpTime'] != null ? map['WekeUpTime'] : '',
      TrainTime: map['TrainTime'] != null ? map['TrainTime'] : '',
      SleepTime: map['SleepTime'] != null ? map['SleepTime'] : '',
      Age: map['Age'] != null ? map['Age'] : 0,
      ActivityLevel: map['ActivityLevel'] != null ? map['ActivityLevel'] : 0,
      Triceps: map['Triceps'] != null ? map['Triceps'] : 0.0,
      Biceps: map['Biceps'] != null ? map['Biceps'] : 0.0,
      Chest: map['Chest'] != null ? map['Chest'] : 0.0,
      Subscap: map['Subscap'] != null ? map['Subscap'] : 0.0,
      Midax: map['Midax'] != null ? map['Midax'] : 0.0,
      Suprullic: map['Suprullic'] != null ? map['Suprullic'] : 0.0,
      Abs: map['Abs'] != null ? map['Abs'] : 0.0,
      Thigh: map['Thigh'] != null ? map['Thigh'] : 0.0,
      Hamstring: map['Hamstring'] != null ? map['Hamstring'] : 0.0,
      Knee: map['Knee'] != null ? map['Knee'] : 0.0,
      UserId: map['UserId'] != null ? map['UserId'] : 0,
      ShortDate: map['ShortDate'] != null ? map['ShortDate'] : '',
      LongDate: map['LongDate'] != null ? map['LongDate'] : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'Height': this.Height,
      'Weight': this.Weight,
      'WeightGoal': this.WeightGoal,
      'WekeUpTime': this.WekeUpTime,
      'TrainTime': this.TrainTime,
      'SleepTime': this.SleepTime,
      'Age': this.Age,
      'ActivityLevel': this.ActivityLevel,
      'Triceps': this.Triceps,
      'Biceps': this.Biceps,
      'Chest': this.Chest,
      'Subscap': this.Subscap,
      'Midax': this.Midax,
      'Suprullic': this.Suprullic,
      'Abs': this.Abs,
      'Thigh': this.Thigh,
      'Hamstring': this.Hamstring,
      'Knee': this.Knee,
      'UserId': this.UserId,
      'ShortDate': this.ShortDate,
      'LongDate': this.LongDate,
    };
  }

//</editor-fold>

}
