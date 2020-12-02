import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:global_gym/models/user_models/main_login_response.dart';
import 'package:global_gym/models/user_models/main_signup_response.dart';
import 'package:global_gym/models/user_models/user_in_send.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/urls.dart';

class Auth with ChangeNotifier {
  String _token;
  String _hashId;

  bool _isLoggedIn;

  String _userName;

  bool get isAuth {
    getToken();
    return _token != null && _token != '';
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  String get token => _token;

  String get hashId => _hashId;

  Future<String> sendVerificationCode(String email) async {
    print('sendVerificationCode');

    final url = Urls.rootUrl + Urls.addForRegisterEndPoint;
    print(url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': Urls.versionCode
        },
        body: json.encode(
          {
            'UserName': email,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);

      try {
        print('000000000');

        MainLoginResponse mainLoginResponse =
            MainLoginResponse.fromJson(responseData);
        print('111111111');

        if (mainLoginResponse.IsSuccess) {
          _hashId = mainLoginResponse.Value.HashId;
          print(_hashId);
          _userName = mainLoginResponse.Value.UserName;

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('HashId', _hashId);
          print('22222222');
          print('mainLoginResponse.IsSuccess' +
              mainLoginResponse.IsSuccess.toString());

          return mainLoginResponse.IsSuccess.toString();
        } else {
          return mainLoginResponse.Message;
        }
      } catch (error) {
        _isLoggedIn = false;

        _hashId = '';
        print('errroooorr');
        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<String> authenticate(
    String verificationCode,
  ) async {
    final url = Urls.rootUrl + Urls.confirmationCodesEndPoint;

    print(url);

    try {
      print(verificationCode);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'version': Urls.versionCode
          },
          body: json.encode({
            'HashId': _hashId,
            'UserName': _userName,
            'ConfirmCode': verificationCode,
          }));

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainLoginResponse mainLoginResponse =
            MainLoginResponse.fromJson(responseData);
        if (mainLoginResponse.IsSuccess) {
          _hashId = mainLoginResponse.Value.HashId;
          print(_hashId);

          _userName = mainLoginResponse.Value.UserName;

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('_hashId', _hashId);

          print(_token);
          prefs.setString('isLogin', 'true');
          notifyListeners();

          return mainLoginResponse.IsSuccess.toString();
        } else {
          return mainLoginResponse.Message;
        }
      } catch (error) {
        notifyListeners();

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<String> sendInfo(UserInSend userInSend) async {
    print('sendInfo');

    final url = Urls.rootUrl + Urls.addUserEndPoint;

    print(url);

    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'version': Urls.versionCode
          },
          body: json.encode(userInSend.toJson()));

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainSignUpResponse mainSignUpResponse =
            MainSignUpResponse.fromJson(responseData);

        if (mainSignUpResponse.IsSuccess) {
          _token = mainSignUpResponse.Value.Token;

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('token', _token);

          print(_token);
          prefs.setString('isLogin', 'true');
          notifyListeners();

          return mainSignUpResponse.IsSuccess.toString();
        } else {
          return mainSignUpResponse.Message;
        }
      } catch (error) {
        notifyListeners();

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<String> userLogin(String email, String password) async {
    print('userLogin');

    final url = Urls.rootUrl + Urls.loginEndPoint;

    print(url);
    print(email);
    print(password);

    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            "UserName": email,
            "Password": password,
          }));

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainSignUpResponse mainSignUpResponse =
            MainSignUpResponse.fromJson(responseData);
        if (mainSignUpResponse.IsSuccess) {
          _token = mainSignUpResponse.Value.Token;

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('token', _token);

          print(_token);
          prefs.setString('isLogin', 'true');
          notifyListeners();

          return mainSignUpResponse.IsSuccess.toString();
        } else {
          return mainSignUpResponse.Message;
        }
      } catch (error) {
        notifyListeners();

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<String> sendForgetCode(String email) async {
    print('sendForgetCode');

    final url = Urls.rootUrl + Urls.addForForgetPasswordEndPoint;
    print(url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': Urls.versionCode
        },
        body: json.encode(
          {
            'UserName': email,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);

      try {
        print('000000000');

        MainLoginResponse mainLoginResponse =
            MainLoginResponse.fromJson(responseData);
        print('111111111');

        if (mainLoginResponse.IsSuccess) {
          _hashId = mainLoginResponse.Value.HashId;
          print(_hashId);
          _userName = mainLoginResponse.Value.UserName;

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('HashId', _hashId);
          print('22222222');
          print('mainLoginResponse.IsSuccess' +
              mainLoginResponse.IsSuccess.toString());

          return mainLoginResponse.IsSuccess.toString();
        } else {
          return mainLoginResponse.Message;
        }
      } catch (error) {
        _isLoggedIn = false;

        _hashId = '';
        print('errroooorr');
        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<String> sendNewPassword(String password, String rePassword) async {
    print('sendVerificationCode');

    final url = Urls.rootUrl + Urls.changePasswordEndPoint;
    print(url);
    print(_userName);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': Urls.versionCode
        },
        body: json.encode(
          {
            'HashId': _hashId,
            'UserName': _userName,
            'Password': password,
            'RePassword': rePassword,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);

      try {
        print('000000000');

        MainLoginResponse mainLoginResponse =
            MainLoginResponse.fromJson(responseData);
        print('111111111');

        if (mainLoginResponse.IsSuccess) {
          _hashId = mainLoginResponse.Value.HashId;
          print(_hashId);

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('HashId', _hashId);
          print('22222222');
          print('mainLoginResponse.IsSuccess' +
              mainLoginResponse.IsSuccess.toString());

          return mainLoginResponse.IsSuccess.toString();
        } else {
          return mainLoginResponse.Message;
        }
      } catch (error) {
        _isLoggedIn = false;

        _hashId = '';
        print('errroooorr');
        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');

    notifyListeners();
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _token = '';
    print('toookeeen');
    print(prefs.getString('token'));
    notifyListeners();
  }
}
