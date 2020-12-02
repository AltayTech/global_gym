import 'package:flutter/foundation.dart';

class UserInSend with ChangeNotifier {
  String hashId;
  String userName;
  String password;
  String rePassword;
  String firstName;
  String lastName;
  String brithDate;
  bool gender;
  String phoneNumber;
  String contactEmergencyName;
  String contactEmergencyNumber;
  String contactEmergencyRelation;
  String addressLine1;
  String addressLine2;
  String subrub;
  String postalCode;

  UserInSend({
    this.hashId,
    this.userName,
    this.password,
    this.rePassword,
    this.firstName,
    this.lastName,
    this.brithDate,
    this.gender,
    this.phoneNumber,
    this.contactEmergencyName,
    this.contactEmergencyNumber,
    this.contactEmergencyRelation,
    this.addressLine1,
    this.addressLine2,
    this.subrub,
    this.postalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'HashId': hashId,
      'UserName': userName,
      'Password': password,
      'RePassword': rePassword,
      'FirstName': firstName,
      'LastName': lastName,
      'BrithDate': brithDate,
      'Gender': gender,
      'PhoneNumber': phoneNumber,
      'ContactEmergencyName': contactEmergencyName,
      'ContactEmergencyNumber': contactEmergencyNumber,
      'ContactEmergencyRelation': contactEmergencyRelation,
      'AddressLine1': addressLine1,
      'AddressLine2': addressLine2,
      'Subrub': subrub,
      'PostalCode': postalCode,
    };
  }
}
