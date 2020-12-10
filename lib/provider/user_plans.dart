import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/models/MainBill.dart';
import 'package:global_gym/models/orderMeal/MainOrder.dart';
import 'package:global_gym/models/MainReserve.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/models/main_exercises.dart';
import 'package:global_gym/models/main_meals.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/models/measurment/MainMeasurement.dart';
import 'package:global_gym/models/measurment/MainMeasurementDetail.dart';
import 'package:global_gym/models/measurment/Measurement.dart';
import 'package:global_gym/models/nutrition.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';
import 'package:global_gym/models/orderMeal/FoodOrder.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';
import 'package:global_gym/models/orderMeal/MainFoodCart.dart';
import 'package:global_gym/models/orderMeal/MainFoodGroup.dart';
import 'package:global_gym/models/orderMeal/Order.dart';
import 'package:global_gym/models/week_day_exercise.dart';
import 'package:global_gym/provider/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserPlans with ChangeNotifier {
  var _token;

  List<Nutrition> nutritions = [];

  List<Meal> mealList = [];

  Future<String> getMeals() async {
    print('getMeals');

    final url = Urls.rootUrl + Urls.getDietEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

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

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainMeals mainMeals = MainMeals.fromJson(responseData);

        if (mainMeals.IsSuccess) {
          notifyListeners();

          mealList = mainMeals.Value;

          return mainMeals.IsSuccess.toString();
        } else {
          return mainMeals.Message;
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

  // List<Exercise> exercises = [];

  List<WeekDayExercises> weekDayExerciseList = [];

  Future<String> getExercise() async {
    print('getExercise');

    final url = Urls.rootUrl + Urls.getExerciseEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

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

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainExercises mainExercises = MainExercises.fromJson(responseData);

        if (mainExercises.IsSuccess) {
          notifyListeners();

          weekDayExerciseList = mainExercises.Value;
          print(mainExercises.Message.toString());

          return mainExercises.IsSuccess.toString();
        } else {
          print(mainExercises.Message.toString());

          return mainExercises.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

// fetch the food items from

  List<FoodGroup> foodGroupList;

  FoodOrderCart foodOrderInfo;

  Future<String> getFoodList() async {
    print('getFoodList');

    final url = Urls.rootUrl + Urls.getFoodGroupListEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

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

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainFoodGroup mainExercises = MainFoodGroup.fromMap(responseData);

        if (mainExercises.IsSuccess) {
          foodGroupList = mainExercises.Value;
          print(mainExercises.Message.toString());
          getOrderCart().then((value) {
            if (value == 'true')
              notifyListeners();
            else if (value == 'empty') {
              foodOrderInfo = FoodOrderCart(
                  HashFoodOrderId: null,
                  IsEmptyFoodOrder: null,
                  OrderStatusTypes: null,
                  FoodOrderInfo: FoodOrder(FoodOrderDetails: []));
              notifyListeners();
            }
          });

          return mainExercises.IsSuccess.toString();
        } else {
          print(mainExercises.Message.toString());

          return mainExercises.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<FoodCart> mealItemList = [];

  Future<String> addFoodToCart(int foodId) async {
    print('addFoodToCart');

    final url = Urls.rootUrl + Urls.addFoodToCartEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    var _hashId = prefs.getString('hashId');
    print(_hashId);

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'version': Urls.versionCode
          },
          body: jsonEncode({
            "HashFoodOrderId": _hashId,
            "FoodId": foodId,
          }));

      final responseData = json.decode(response.body);
      print(responseData);

      MainFoodCart mainFoodCart = MainFoodCart.fromMap(responseData);

      if (mainFoodCart.IsSuccess) {
        foodOrderInfo = mainFoodCart.Value;
        print(mainFoodCart.Message.toString());
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        _hashId = mainFoodCart.Value.HashFoodOrderId;
        prefs.setString('hashId', _hashId);

        return mainFoodCart.IsSuccess.toString();
      } else {
        print(mainFoodCart.Message.toString());
        return mainFoodCart.Message;
      }
    } catch (error) {
      notifyListeners();
      print(error.toString());
      throw error;
    }
  }

  Future<String> decreaseFoodToCart(int foodId) async {
    print('decreaseFoodToCart');

    final url = Urls.rootUrl + Urls.decreaseFoodToCartEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    var _hashId = prefs.getString('hashId');
    print(_hashId);

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'version': Urls.versionCode
          },
          body: jsonEncode({
            "HashFoodOrderId": _hashId,
            "FoodId": foodId,
          }));

      final responseData = json.decode(response.body);
      print(responseData);

      MainFoodCart mainFoodCart = MainFoodCart.fromMap(responseData);

      if (mainFoodCart.IsSuccess) {
        foodOrderInfo = mainFoodCart.Value;
        print(mainFoodCart.Message.toString());
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        _hashId = mainFoodCart.Value.HashFoodOrderId;

        prefs.setString('hashId', _hashId);

        return mainFoodCart.IsSuccess.toString();
      } else {
        print(mainFoodCart.Message.toString());

        return mainFoodCart.Message;
      }
    } catch (error) {
      print(error.toString());
      notifyListeners();
      throw error;
    }
  }

  Future<String> removeFoodFromCart(int foodId) async {
    print('decreaseFoodToCart');

    final url = Urls.rootUrl + Urls.removeFoodFromCartEndPoint;

    print(url);
    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    var _hashId = prefs.getString('hashId');

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'version': Urls.versionCode
          },
          body: jsonEncode({
            "HashFoodOrderId": _hashId,
            "FoodId": foodId,
          }));

      final responseData = json.decode(response.body);
      print(responseData);

      MainFoodCart mainFoodCart = MainFoodCart.fromMap(responseData);

      if (mainFoodCart.IsSuccess) {
        foodOrderInfo = mainFoodCart.Value;
        print(mainFoodCart.Message.toString());
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        _hashId = mainFoodCart.Value.HashFoodOrderId;

        prefs.setString('hashId', _hashId);

        return mainFoodCart.IsSuccess.toString();
      } else {
        print(mainFoodCart.Message.toString());

        return mainFoodCart.Message;
      }
    } catch (error) {
      print(error.toString());
      notifyListeners();
      throw error;
    }
  }

  Future<String> getOrderCart() async {
    print('getOrderCart');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    var _hashId = prefs.getString('hashId');
    print(_hashId);
    if (_hashId != null && _hashId != '') {
      final url = Urls.rootUrl + Urls.getFoodToCartEndPoint + '?HashFoodOrderId=$_hashId';

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

        final responseData = json.decode(response.body);

        MainFoodCart mainFoodCart = MainFoodCart.fromMap(responseData);

        if (mainFoodCart.IsSuccess) {
          foodOrderInfo = mainFoodCart.Value;
          print(mainFoodCart.Message.toString());

          final prefs = await SharedPreferences.getInstance();
          _hashId = mainFoodCart.Value.HashFoodOrderId;

          prefs.setString('hashId', _hashId);

          notifyListeners();
          return mainFoodCart.IsSuccess.toString();
        } else if (!mainFoodCart.IsSuccess) {
          if (mainFoodCart.Value.IsEmptyFoodOrder) {
            prefs.setString('hashId', _hashId);
            notifyListeners();
            return "empty";
          } else
            return mainFoodCart.Message;
        } else {
          print(mainFoodCart.Message.toString());
          return mainFoodCart.Message;
        }
      } catch (error) {
        notifyListeners();
        print(error.toString());
        throw error;
      }
    } else {
      foodOrderInfo = FoodOrderCart(
          HashFoodOrderId: null,
          IsEmptyFoodOrder: null,
          OrderStatusTypes: null,
          FoodOrderInfo: FoodOrder(FoodOrderDetails: []));
      notifyListeners();
      return 'No item in cart';
    }
  }

  Future<String> finalizeOrderCart() async {
    print('finalizeOrderCart');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    var _hashId = prefs.getString('hashId');
    print(_hashId);

    final url = Urls.rootUrl + Urls.finalizeFoodToCartEndPoint;

    print(url);

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'version': Urls.versionCode
          },
          body: jsonEncode({
            "HashFoodOrderId": _hashId,
          }));
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainFoodCart mainFoodCart = MainFoodCart.fromMap(responseData);
        print('oookkkkkkkkkkkk');

        if (mainFoodCart.IsSuccess) {
          foodOrderInfo = FoodOrderCart(
              HashFoodOrderId: null,
              IsEmptyFoodOrder: null,
              OrderStatusTypes: null,
              FoodOrderInfo: FoodOrder(FoodOrderDetails: []));

          print(mainFoodCart.Message.toString());

          final prefs = await SharedPreferences.getInstance();

          prefs.setString('hashId', '');
          getFoodList();
          notifyListeners();

          return mainFoodCart.IsSuccess.toString();
        } else {
          print(mainFoodCart.Message.toString());

          return mainFoodCart.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<Measurement> measurementList = [];

  Future<String> getMeasurement() async {
    print('getMeasurement');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    final url = Urls.rootUrl + Urls.getMeasurementEndPoint;

    print(url);

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
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainMeasurement mainMeasurement = MainMeasurement.fromMap(responseData);
        print('oookkkkkkkkkkkk');

        if (mainMeasurement.IsSuccess) {
          notifyListeners();

          measurementList = mainMeasurement.Value;

          print(mainMeasurement.Message.toString());

          return mainMeasurement.IsSuccess.toString();
        } else {
          print(mainMeasurement.Message.toString());

          return mainMeasurement.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Measurement measurementDetail;

  Future<String> getMeasurementDetail(int id) async {
    print('getMeasurementDetail');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    final url = Urls.rootUrl + Urls.getMeasurementDetailEndPoint + '?Id=$id';

    print(url);

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
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainMeasurementDetail mainMeasurementDetail = MainMeasurementDetail.fromMap(responseData);
        print('oookkkkkkkkkkkk');

        if (mainMeasurementDetail.IsSuccess) {
          notifyListeners();

          measurementDetail = mainMeasurementDetail.Value;

          print(mainMeasurementDetail.Message.toString());

          return mainMeasurementDetail.IsSuccess.toString();
        } else {
          print(mainMeasurementDetail.Message.toString());

          return mainMeasurementDetail.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<Reserve> reserveList;

  Future<String> getReserveList(String date) async {
    print('getReserveList');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    final url = Urls.rootUrl + Urls.getReserveListEndPoint + '?FilteredDate=$date';

    print(url);

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
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainReserve mainReserve = MainReserve.fromJson(responseData);
        print('oookkkkkkkkkkkk');

        if (mainReserve.IsSuccess) {
          notifyListeners();

          reserveList = mainReserve.Value;

          print(mainReserve.Message.toString());

          return mainReserve.IsSuccess.toString();
        } else {
          print(mainReserve.Message.toString());

          return mainReserve.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<Bill> billList;

  Future<String> getBillList() async {
    print('getBillList');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    final url = Urls.rootUrl + Urls.getFPaymentsEndPoint;

    print(url);

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
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainBill mainBill = MainBill.fromJson(responseData);
        print('oookkkkkkkkkkkk');

        if (mainBill.IsSuccess) {
          notifyListeners();

          billList = mainBill.Value;

          print(mainBill.Message.toString());

          return mainBill.IsSuccess.toString();
        } else {
          print(mainBill.Message.toString());

          return mainBill.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<Order> orderList = [];

  Future<String> getOrderList() async {
    print('getOrderList');

    final prefs = await SharedPreferences.getInstance();

    var _token = prefs.getString('token');
    print(_token);

    final url = Urls.rootUrl + Urls.getFoodOrderHistoryEndPoint + '/?OrderStatusType=1';

    print(url);

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
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      try {
        MainOrder mainOrder = MainOrder.fromJson(responseData);
        print('oookkkkkkkkkkkk');

        if (mainOrder.IsSuccess) {
          notifyListeners();

          orderList = mainOrder.Value;

          print(mainOrder.Message.toString());

          return mainOrder.IsSuccess.toString();
        } else {
          print(mainOrder.Message.toString());

          return mainOrder.Message;
        }
      } catch (error) {
        notifyListeners();
        print('sssssssssssssssssssssss');

        return false.toString();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
