import 'package:flutter/foundation.dart';

class SurveyQuestion with ChangeNotifier {
  final int id;
  final String content;
   bool answer;

  SurveyQuestion({
    this.id,
    this.content,
    this.answer,
  });

  // factory User.fromJson(Map<String, dynamic> parsedJson) {
  //   return User(
  //     hashId: parsedJson['id'] != null ? parsedJson['id'] : 0,
  //     userName: parsedJson['fname'] != null ? parsedJson['fname'] : '',
  //     password: parsedJson['lname'] != null ? parsedJson['lname'] : '',
  //     address: parsedJson['address'] != null ? parsedJson['address'] : '',
  //     gender: parsedJson['gender'] != null ? parsedJson['gender'] : 0,
  //     phone: parsedJson['phone'] != null ? parsedJson['phone'] : '',
  //     mobile: parsedJson['mobile'] != null ? parsedJson['mobile'] : '',
  //     no_comments:
  //         parsedJson['no_comments'] != null ? parsedJson['no_comments'] : 0,
  //     no_likes: parsedJson['no_likes'] != null ? parsedJson['no_likes'] : 0,
  //     no_reserves:
  //         parsedJson['no_reserves'] != null ? parsedJson['no_reserves'] : 0,
  //     wallet: parsedJson['wallet'] != null ? parsedJson['wallet'] : '',
  //     email: parsedJson['email'] != null ? parsedJson['email'] : '',
  //     created_at:
  //         parsedJson['created_at'] != null ? parsedJson['created_at'] : '',
  //     updated_at:
  //         parsedJson['updated_at'] != null ? parsedJson['updated_at'] : '',
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'answer': answer,
    };
  }
}
