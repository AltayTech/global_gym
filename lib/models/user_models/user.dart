import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  int Id;
  String UserName;
  String FirstName;
  String LastName;
  int isActive;
  bool isActiveName;
  String GenderName;
  String BrithDate;

  String PhoneNumber;
  String ContactEmergencyName;
  String ContactEmergencyNumber;
  String ContactEmergencyRelation;
  String AddressLine1;
  String AddressLine2;
  String Subrub;
  String PostalCode;
  int Gender;
  String UserFullName;
  String PersonalPicPath;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.Id,
    @required this.UserName,
    @required this.FirstName,
    @required this.LastName,
    @required this.isActive,
    @required this.isActiveName,
    @required this.GenderName,
    @required this.BrithDate,
    @required this.PhoneNumber,
    @required this.ContactEmergencyName,
    @required this.ContactEmergencyNumber,
    @required this.ContactEmergencyRelation,
    @required this.AddressLine1,
    @required this.AddressLine2,
    @required this.Subrub,
    @required this.PostalCode,
    @required this.Gender,
    @required this.UserFullName,
    @required this.PersonalPicPath,
  });

  User copyWith({
    int Id,
    String UserName,
    String FirstName,
    String LastName,
    int isActive,
    bool isActiveName,
    String GenderName,
    String BrithDate,
    String PhoneNumber,
    String ContactEmergencyName,
    String ContactEmergencyNumber,
    String ContactEmergencyRelation,
    String AddressLine1,
    String AddressLine2,
    String Subrub,
    String PostalCode,
    int Gender,
    String UserFullName,
    String PersonalPicPath,
  }) {
    return new User(
      Id: Id ?? this.Id,
      UserName: UserName ?? this.UserName,
      FirstName: FirstName ?? this.FirstName,
      LastName: LastName ?? this.LastName,
      isActive: isActive ?? this.isActive,
      isActiveName: isActiveName ?? this.isActiveName,
      GenderName: GenderName ?? this.GenderName,
      BrithDate: BrithDate ?? this.BrithDate,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      ContactEmergencyName: ContactEmergencyName ?? this.ContactEmergencyName,
      ContactEmergencyNumber: ContactEmergencyNumber ?? this.ContactEmergencyNumber,
      ContactEmergencyRelation: ContactEmergencyRelation ?? this.ContactEmergencyRelation,
      AddressLine1: AddressLine1 ?? this.AddressLine1,
      AddressLine2: AddressLine2 ?? this.AddressLine2,
      Subrub: Subrub ?? this.Subrub,
      PostalCode: PostalCode ?? this.PostalCode,
      Gender: Gender ?? this.Gender,
      UserFullName: UserFullName ?? this.UserFullName,
      PersonalPicPath: PersonalPicPath ?? this.PersonalPicPath,
    );
  }

  @override
  String toString() {
    return 'User{Id: $Id, UserName: $UserName, FirstName: $FirstName, LastName: $LastName, isActive: $isActive, isActiveName: $isActiveName, GenderName: $GenderName, BrithDate: $BrithDate, PhoneNumber: $PhoneNumber, ContactEmergencyName: $ContactEmergencyName, ContactEmergencyNumber: $ContactEmergencyNumber, ContactEmergencyRelation: $ContactEmergencyRelation, AddressLine1: $AddressLine1, AddressLine2: $AddressLine2, Subrub: $Subrub, PostalCode: $PostalCode, Gender: $Gender, UserFullName: $UserFullName, PersonalPicPath: $PersonalPicPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is User &&
              runtimeType == other.runtimeType &&
              Id == other.Id &&
              UserName == other.UserName &&
              FirstName == other.FirstName &&
              LastName == other.LastName &&
              isActive == other.isActive &&
              isActiveName == other.isActiveName &&
              GenderName == other.GenderName &&
              BrithDate == other.BrithDate &&
              PhoneNumber == other.PhoneNumber &&
              ContactEmergencyName == other.ContactEmergencyName &&
              ContactEmergencyNumber == other.ContactEmergencyNumber &&
              ContactEmergencyRelation == other.ContactEmergencyRelation &&
              AddressLine1 == other.AddressLine1 &&
              AddressLine2 == other.AddressLine2 &&
              Subrub == other.Subrub &&
              PostalCode == other.PostalCode &&
              Gender == other.Gender &&
              UserFullName == other.UserFullName &&
              PersonalPicPath == other.PersonalPicPath);

  @override
  int get hashCode =>
      Id.hashCode ^
      UserName.hashCode ^
      FirstName.hashCode ^
      LastName.hashCode ^
      isActive.hashCode ^
      isActiveName.hashCode ^
      GenderName.hashCode ^
      BrithDate.hashCode ^
      PhoneNumber.hashCode ^
      ContactEmergencyName.hashCode ^
      ContactEmergencyNumber.hashCode ^
      ContactEmergencyRelation.hashCode ^
      AddressLine1.hashCode ^
      AddressLine2.hashCode ^
      Subrub.hashCode ^
      PostalCode.hashCode ^
      Gender.hashCode ^
      UserFullName.hashCode ^
      PersonalPicPath.hashCode;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      Id: map['Id'] != null ? map['Id'] : 0,
      UserName: map['UserName'] != null ? map['UserName'] : '',
      FirstName: map['FirstName'] != null ? map['FirstName'] : '',
      LastName: map['LastName'] != null ? map['LastName'] : '',
      isActive: map['isActive'] != null ? map['isActive'] : 1,
      isActiveName: map['isActiveName'] != null ? map['isActiveName'] : true,
      GenderName: map['GenderName'] != null ? map['GenderName'] : '',
      BrithDate: map['BrithDate'] != null ? map['BrithDate'] : '',
      PhoneNumber: map['PhoneNumber'] != null ? map['PhoneNumber'] : '',
      ContactEmergencyName: map['ContactEmergencyName'] != null ? map['ContactEmergencyName'] : '',
      ContactEmergencyNumber: map['ContactEmergencyNumber'] != null ? map['ContactEmergencyNumber'] :'',
      ContactEmergencyRelation: map['ContactEmergencyRelation'] != null ? map['ContactEmergencyRelation'] : '',
      AddressLine1: map['AddressLine1'] != null ? map['AddressLine1'] :'',
      AddressLine2: map['AddressLine2'] != null ? map['AddressLine2'] : '',
      Subrub: map['Subrub'] != null ? map['Subrub'] : '',
      PostalCode: map['PostalCode'] != null ? map['PostalCode'] : '',
      Gender: map['Gender'] != null ? map['Gender'] : 1,
      UserFullName: map['UserFullName'] != null ? map['UserFullName'] : '',
      PersonalPicPath: map['PersonalPicPath'] != null ? map['PersonalPicPath'] : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'UserName': this.UserName,
      'FirstName': this.FirstName,
      'LastName': this.LastName,
      'isActive': this.isActive,
      'isActiveName': this.isActiveName,
      'GenderName': this.GenderName,
      'BrithDate': this.BrithDate,
      'PhoneNumber': this.PhoneNumber,
      'ContactEmergencyName': this.ContactEmergencyName,
      'ContactEmergencyNumber': this.ContactEmergencyNumber,
      'ContactEmergencyRelation': this.ContactEmergencyRelation,
      'AddressLine1': this.AddressLine1,
      'AddressLine2': this.AddressLine2,
      'Subrub': this.Subrub,
      'PostalCode': this.PostalCode,
      'Gender': this.Gender,
      'UserFullName': this.UserFullName,
      'PersonalPicPath': this.PersonalPicPath,
    };
  }

//</editor-fold>

}
