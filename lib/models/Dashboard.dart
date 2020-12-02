import 'package:flutter/foundation.dart';
import 'package:global_gym/models/exercise.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/models/user_models/user.dart';

class Dashboard with ChangeNotifier {
  User CustomerUsers;

  List<Meal> UserDiets;
  List<Exercise> UserTraningPrograms;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Dashboard({
    @required this.CustomerUsers,
    @required this.UserDiets,
    @required this.UserTraningPrograms,
  });

  Dashboard copyWith({
    User CustomerUsers,
    List<Meal> UserDiets,
    List<Exercise> UserTraningPrograms,
  }) {
    if ((CustomerUsers == null || identical(CustomerUsers, this.CustomerUsers)) &&
        (UserDiets == null || identical(UserDiets, this.UserDiets)) &&
        (UserTraningPrograms == null || identical(UserTraningPrograms, this.UserTraningPrograms))) {
      return this;
    }

    return new Dashboard(
      CustomerUsers: CustomerUsers ?? this.CustomerUsers,
      UserDiets: UserDiets ?? this.UserDiets,
      UserTraningPrograms: UserTraningPrograms ?? this.UserTraningPrograms,
    );
  }

  @override
  String toString() {
    return 'Dashboard{CustomerUsers: $CustomerUsers, UserDiets: $UserDiets, UserTraningPrograms: $UserTraningPrograms}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dashboard &&
          runtimeType == other.runtimeType &&
          CustomerUsers == other.CustomerUsers &&
          UserDiets == other.UserDiets &&
          UserTraningPrograms == other.UserTraningPrograms);

  @override
  int get hashCode => CustomerUsers.hashCode ^ UserDiets.hashCode ^ UserTraningPrograms.hashCode;

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    List<Meal> userDietsValue = [];

    if (map['UserDiets'] != null) {
      var nutritionList = map['UserDiets'] as List;
      userDietsValue = nutritionList.map((i) => Meal.fromJson(i)).toList();
    }

    List<Exercise> userTraningProgramsValue = [];

    if (map['UserTraningPrograms'] != null) {
      var nutritionList = map['UserTraningPrograms'] as List;
      userTraningProgramsValue = nutritionList.map((i) => Exercise.fromJson(i)).toList();
    }

    return new Dashboard(
      CustomerUsers: User.fromMap(map['CustomerUsers']),
      UserDiets: userDietsValue,
      UserTraningPrograms: userTraningProgramsValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CustomerUsers': this.CustomerUsers,
      'UserDiets': this.UserDiets,
      'UserTraningPrograms': this.UserTraningPrograms,
    };
  }

//</editor-fold>

}
