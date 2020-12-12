import 'package:flutter/material.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodGroupSelfeMade.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodSelfMade.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_meal/order_meal_self_made_list.dart';
import 'package:global_gym/screen/user_profile/user_register_survey_complete_screen.dart';
import 'package:provider/provider.dart';

class OrderMealSelfMade extends StatefulWidget {
  static const routeName = '/OrderMealSelfMade';

  @override
  _OrderMealSelfMadeState createState() => _OrderMealSelfMadeState();
}

class _OrderMealSelfMadeState extends State<OrderMealSelfMade> {
  int itemIndex = 0;

  bool _isInit = true;

  var _isLoading;

  String _snackBarMessage = '';

  List<FoodGroupSelfMade> listFoodGroup = [];

  int selectedIndex = 0;

  List<String> headerIcon = [
    'assets/images/food_group_1.png',
    'assets/images/food_group_2.png',
    'assets/images/food_group_3.png',
    'assets/images/food_group_3.png',
    'assets/images/food_group_3.png',
    'assets/images/food_group_3.png',
  ];

  List<FoodSelfMade> foodValueList = [];

  String foodValue;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getFoodGroup().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          listFoodGroup = await Provider.of<UserPlans>(context, listen: false).foodGroupSelfMade;
          foodValueList = listFoodGroup[itemIndex].SelfMadeFoods;
        } else {
          _snackBarMessage = value;
          showNotification(context, _snackBarMessage);
        }
      });
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> selectFood(bool isForward) async {
    if (isForward) {
      debugPrint(listFoodGroup.length.toString());
      debugPrint(itemIndex.toString());

      if (itemIndex < listFoodGroup.length - 1) {
        if (listFoodGroup[itemIndex].SelfMadeFoods.isNotEmpty)
          Provider.of<UserPlans>(context, listen: false).selectedSelfMade[itemIndex] =
              listFoodGroup[itemIndex].SelfMadeFoods[selectedIndex];
        itemIndex++;
        debugPrint(foodValueList.length.toString());

        selectedIndex=0;
        foodValue=null;
        foodValueList = listFoodGroup[itemIndex].SelfMadeFoods;
        debugPrint(foodValueList.length.toString());
        setState(() {});
      } else if (itemIndex == listFoodGroup.length - 1) {
        Navigator.of(context).pushNamed(OrderMealSelfMadeList.routeName);
      }
    } else {
      if (itemIndex > 0) {
        itemIndex--;
        setState(() {});
      }
    }
  }

  Future<String> getFoodGroup() async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false).getFoodGroupSelfMadeList();

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<void> showNotification(BuildContext ctx, String message) async {
    SnackBar addToCartSnackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'CircularStd',
          fontSize: 14.0,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    Scaffold.of(ctx).showSnackBar(addToCartSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            height: 4,
            child: ListView.builder(
              itemCount: listFoodGroup.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 2,
                  width: 20,
                  color: index <= itemIndex ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              height: deviceHeight * 0.8,
              child: SafeArea(
                child: Column(
                  children: [
                    Image.asset(
                      headerIcon[itemIndex],
                      height: 90,
                      width: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 37, right: 37, bottom: 16),
                      child: Text(
                        'Select Your ${listFoodGroup[itemIndex].Name}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CircularStd',
                          fontWeight: FontWeight.w800,
                          fontSize: textScaleFactor * 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 37, right: 37, bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(0)),
                          child: DropdownButton<String>(

                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _isLoading ? 'Please wait' : 'Please select',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'CircularStd',
                                  fontSize: textScaleFactor * 11.0,
                                ),
                              ),
                            ),
                            value: foodValue,
                            icon: Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CircularStd',
                              fontSize: textScaleFactor * 13.0,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                foodValue = newValue;
                                selectedIndex = foodValueList.indexWhere((element) => element.Name == newValue);
                              });
                            },
                            elevation: 0,
                            underline: Container(
                              color: Colors.white,
                            ),
                            items: foodValueList.map<DropdownMenuItem<String>>((FoodSelfMade value) {
                              return DropdownMenuItem<String>(

                                value: value.Name,
                                child: Container(
                                  width: deviceWidth * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      value.Name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd',
                                        fontSize: textScaleFactor * 13.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 80, left: 37, right: 37),
                      child: InkWell(
                        onTap: () {
                          debugPrint('1111');
                          selectFood(true);
                        },
                        child: Container(
                          height: 48,
                          width: 340,
                          decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Text(
                              itemIndex < listFoodGroup.length - 1 ? 'Next' : 'Show My Meal',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w800,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 37, right: 37),
                      child: InkWell(
                        onTap: () {
                          selectFood(false);
                        },
                        child: Container(
                          height: 48,
                          width: 340,
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Text(
                              'Back',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w800,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
