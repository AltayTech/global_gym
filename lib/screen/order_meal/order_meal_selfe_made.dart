import 'package:flutter/material.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodGroupSelfeMade.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodSelfMade.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_meal/order_meal_self_made_list.dart';
import 'package:global_gym/widget/items/custom_drop_down_list.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class OrderMealSelfMade extends StatefulWidget {
  static const routeName = '/OrderMealSelfMade';

  @override
  _OrderMealSelfMadeState createState() => _OrderMealSelfMadeState();
}

class _OrderMealSelfMadeState extends State<OrderMealSelfMade> {
  int itemIndex = 0;

  var _isLoading = false;

  List<FoodGroupSelfMade> foodGroupSelfMade = [];

  int selectedIndex = -1;

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

  Future addToCart(int foodId) async {

    await Provider.of<UserPlans>(context, listen: false).addSelfMadeFoodToCart(foodId);

  }


  Future<void> selectFood(BuildContext context, bool isForward) async {

    if (isForward) {
      debugPrint(foodGroupSelfMade.length.toString());
      debugPrint(itemIndex.toString());

      // if(itemIndex == 0)
      //   Provider.of<UserPlans>(context, listen: false).selectedSelfMade = List<FoodSelfMade>.generate(3, (index) => null);


      if (itemIndex < foodGroupSelfMade.length - 1) {
        if (foodGroupSelfMade[itemIndex].SelfMadeFoods.isNotEmpty && selectedIndex >= 0) {
          Provider.of<UserPlans>(context, listen: false).selectedSelfMade[itemIndex] = foodGroupSelfMade[itemIndex].SelfMadeFoods[selectedIndex];
        }
        itemIndex++;
        debugPrint(foodValueList.length.toString());

        selectedIndex = -1;
        foodValue = null;
        foodValueList = foodGroupSelfMade[itemIndex].SelfMadeFoods;
        debugPrint(foodValueList.length.toString());
        setState(() {});
      } else if (itemIndex == foodGroupSelfMade.length - 1) {
        if (foodGroupSelfMade[itemIndex].SelfMadeFoods.isNotEmpty && selectedIndex >= 0)
          Provider.of<UserPlans>(context, listen: false).selectedSelfMade[itemIndex] = foodGroupSelfMade[itemIndex].SelfMadeFoods[selectedIndex];


        if(Provider.of<UserPlans>(context, listen: false).selectedSelfMade != null)
          await addAllToCart(Provider.of<UserPlans>(context, listen: false).selectedSelfMade);

        Navigator.of(context).pushReplacementNamed(OrderMealSelfMadeList.routeName);
      }
    } else {
      if (itemIndex > 0) {
        itemIndex--;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    foodGroupSelfMade = Provider.of<UserPlans>(context).foodGroupSelfMade;
    if(foodGroupSelfMade.isEmpty) {
      setState(() {
        _isLoading = true;
      });
    } else{
      foodValueList = foodGroupSelfMade[itemIndex].SelfMadeFoods;
      setState(() {
        _isLoading = false;
      });
    }

      return Stack(
        children: [
          Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
              ),
              body: foodGroupSelfMade != null ? Container(
                height: deviceHeight,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Container(
                        height: 4,
                        child: Center(
                          child: ListView.builder(
                            itemCount: foodGroupSelfMade.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                height: 2,
                                width: 20,
                                color:
                                    index <= itemIndex ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      headerIcon[itemIndex],
                      height: 90,
                      width: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 37, right: 37, bottom: 16),
                      child: Text(
                        'Select Your ${foodGroupSelfMade[itemIndex].Name}',
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
                      padding: const EdgeInsets.only(
                          top: 40, left: 37, right: 37, bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(0)),
                            child: CustomDropDownList(
                              height: 48,
                              width: 340,
                              itemsList: foodValueList.map((e) => e.Name).toList(),
                              onChanged: (newValue, i) {
                                foodValue = newValue;
                                selectedIndex = i;
                              },
                            )
                            ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 80, left: 37, right: 37),
                      child: InkWell(
                        onTap: () {
                          debugPrint('1111');
                          selectFood(context, true);
                        },
                        child: Container(
                          height: 48,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Text(
                              itemIndex < foodGroupSelfMade.length - 1
                                  ? 'Next'
                                  : 'Show My Meal',
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
                          selectFood(context, false);
                        },
                        child: Container(
                          height: 48,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
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
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ) : Container(child: Text("Network Error!"))),
          _isLoading ? ProgressWidget() : Container(),
        ],
      );
  }

  Future addAllToCart(List<FoodSelfMade> selectedSelfMade) async {

    _isLoading = true;
    setState(() {});

    for(int  i = 0 ;i < selectedSelfMade.length; i++)
      if(selectedSelfMade[i]!=null)
        await addToCart(selectedSelfMade[i].Id);

    _isLoading = false;
    setState(() {});
  }
}
