import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_gym/models/Dashboard.dart';
import 'package:global_gym/models/MainDashboard.dart';
import 'package:global_gym/models/survey_question.dart';
import 'package:global_gym/models/user_models/MainUser.dart';
import 'package:global_gym/models/user_models/main_plans.dart';
import 'package:global_gym/models/user_models/plan.dart';
import 'package:global_gym/models/user_models/user.dart';
import 'package:global_gym/models/user_models/user_in_send.dart';
import 'package:global_gym/provider/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo with ChangeNotifier {
  List<SurveyQuestion> _surveyQuestionList = [
    SurveyQuestion(
      id: 1,
      content: 'Has your doctor ever told you that you have a heart condition or have you ever suffered a stroke?',
      answer: null,
    ),
    SurveyQuestion(
      id: 2,
      content: 'Do you ever experience unexplained pans in your chest at rest or during physical activity/exercise?',
      answer: null,
    ),
    SurveyQuestion(
      id: 3,
      content:
          'Do you ever feel faint or have spells of dizzinessduring physical activity/exercise that causes you to lose balance?',
      answer: null,
    ),
    SurveyQuestion(
      id: 4,
      content:
          'Have you had an asthma attack requiring immediate medical attantion at any tome over the last 12 months?',
      answer: null,
    ),
    SurveyQuestion(
      id: 5,
      content:
          'If you have diabetes (type I or type II ) have you had trouble controlling your blood glucose in the last 3 month?',
      answer: null,
    ),
    SurveyQuestion(
      id: 6,
      content:
          'Do you have any diagnosed muscle, bone or joint problems thet you have been told could be made worse by participainting in physical activity/exercise?',
      answer: null,
    ),
    SurveyQuestion(
      id: 7,
      content:
          'Do you have any other medical condition(s) that may make it dangerouse for you to participate in physical activity/exercise?',
      answer: null,
    ),
  ];

  List<Plan> plans = [];

  String groupValue;


  List<SurveyQuestion> get surveyQuestionList => _surveyQuestionList;

  set surveyQuestionList(List<SurveyQuestion> value) {
    _surveyQuestionList = value;
  }

  static User _user_zero = User();

  User _user = _user_zero;

  User get user => _user;

  UserInSend _userInSend = UserInSend();

  UserInSend get userInSend => _userInSend;

  set userInSend(UserInSend value) {
    _userInSend = value;
  }

  Future<bool> getPlans() async {
    debugPrint('getPlans');

    final url = Urls.rootUrl + Urls.readPlansEndPoint;

    debugPrint(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    debugPrint(_token);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': Urls.versionCode
        },
      );

      final responseData = json.decode(response.body);
      debugPrint(responseData);

      try {
        MainPlans mainPlans = MainPlans.fromJson(responseData);

        plans = mainPlans.Value;

        notifyListeners();

        return mainPlans.IsSuccess;
      } catch (error) {
        notifyListeners();

        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

  Future<String> sendPlan(
      int planId, String BSBNumber, String accountNumber, String accountName, String bankName) async {
    debugPrint('sendPlan');

    final url = Urls.rootUrl + Urls.addPlanEndPoint;

    debugPrint(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    debugPrint(_token);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': Urls.versionCode
        },
        body: json.encode(
          {
            'PlanId': planId,
            'BSBNumber': BSBNumber,
            'AccountNumber': accountNumber,
            'AccountName': accountName,
            'BankName': bankName,
          },
        ),
      );

      final responseData = json.decode(response.body);
      debugPrint(responseData);

      try {
        MainPlans mainPlans = MainPlans.fromJson(responseData);

        if (mainPlans.IsSuccess) {
          notifyListeners();

          return mainPlans.IsSuccess.toString();
        } else {
          return mainPlans.Message;
        }
      } catch (error) {
        notifyListeners();

        return false.toString();
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }


  Future<NetworkImage> getQRCode() async {
    debugPrint('getQRCode');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    debugPrint(_token);

    final url = Urls.rootUrl + Urls.getQRCodeEndPoint;

    debugPrint(url);

    try {

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'image/png',
          // 'version': Urls.versionCode
        },
      );

      final responseData = response.body;
      debugPrint(responseData);

        if (response.statusCode == 200) {

          NetworkImage image = NetworkImage(Urls.rootUrl + Urls.getQRCodeEndPoint, headers: {
            'Authorization': 'Bearer ${prefs.getString('token')}',
            'Content-Type': 'application/json',
            'Accept': 'image/png',
            // 'version': Urls.versionCode
          },);

          return image;
        }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

  Future<String> getUserInfo() async {
    debugPrint('getUserInfo');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    debugPrint(_token);

    final url = Urls.rootUrl + Urls.getProfileEndPoint;

    debugPrint(url);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'version': Urls.versionCode
        },
      );
      debugPrint(response.body);

      final responseData = json.decode(response.body) as Map;
      debugPrint(responseData.toString());

      try {
        MainUser mainUser = MainUser.fromJson(responseData);

        if (mainUser.IsSuccess) {
          notifyListeners();
          debugPrint(mainUser.Value.FirstName);

          _user = mainUser.Value;

          debugPrint(mainUser.Message.toString());

          return mainUser.IsSuccess.toString();
        } else {
          debugPrint(mainUser.Message.toString());

          return mainUser.Message;
        }
      } catch (error) {
        notifyListeners();
        debugPrint('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }


  Dashboard dashboardInfo;


  Future<String> getDashboardInfo() async {
    debugPrint('getDashboardInfo');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    debugPrint(_token);

    final url = Urls.rootUrl + Urls.getDashboardInfoEndPoint;

    debugPrint(url);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'version': Urls.versionCode
        },
      );
      debugPrint(response.body);
      debugPrint('sssssssssssssssssssssss');

      final responseData = json.decode(response.body) as Map;
      debugPrint(responseData.toString());
      debugPrint('sssssssssssssssssssssss');

      try {
        MainDashboard mainDashboard = MainDashboard.fromMap(responseData);

        if (mainDashboard.IsSuccess) {
          notifyListeners();
          debugPrint('sssssssssssssssssssssss');

          dashboardInfo = mainDashboard.Value;

          debugPrint(mainDashboard.Message.toString());

          return mainDashboard.IsSuccess.toString();
        } else {
          debugPrint(mainDashboard.Message.toString());

          return mainDashboard.Message;
        }
      } catch (error) {
        notifyListeners();
        debugPrint('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }
}
