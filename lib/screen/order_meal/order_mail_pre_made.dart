import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/orderMeal/Food.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/order_cart_item.dart';
import 'package:global_gym/widget/items/order_meal_item.dart';
import 'package:provider/provider.dart';

class OrderMealPreMade extends StatefulWidget {
  static const routeName = '/OrderMealPreMade';

  @override
  _OrderMealPreMadeState createState() => _OrderMealPreMadeState();
}

class _OrderMealPreMadeState extends State<OrderMealPreMade> {
  bool _isInit = true;

  var _isLoading = false;

  var _isLoadingCart = false;

  String token;

  String _snackBarMessage = '';

  List<FoodGroup> foodGroupList = [];
  List<Food> foodList = [];

  FoodOrderCart foodOrderInfo;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getFoodList().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          foodGroupList =
              Provider.of<UserPlans>(context, listen: false).foodGroupList;
        } else {
          print('dsfsdssssssssssssssssssss');

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

  Future<String> getFoodList() async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .getFoodList()
        .then((value) {
      if (value == 'true') {}
    });

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> finalizeOrderCart() async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .finalizeOrderCart()
        .then((value) {
      if (value == 'true') {
        return 'Order is send successfully';
      } else {
        return value;
      }
    });

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

  Future<String> getOrderCart() async {
    _isLoadingCart = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .getOrderCart()
        .then((value) {
      if (value == 'true') {
        foodOrderInfo =
            Provider.of<UserPlans>(context, listen: false).foodOrderInfo;
        return 'true';
      } else {
        return 'false';
      }
    });

    _isLoadingCart = false;
    setState(() {});
    return isSent;
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,

      builder: (BuildContext bc) {
        double deviceHeight = MediaQuery.of(bc).size.height;
        double deviceWidth = MediaQuery.of(bc).size.width;
        double textScaleFactor = MediaQuery.of(bc).textScaleFactor;
        foodOrderInfo = Provider.of<UserPlans>(context).foodOrderInfo;
        return
          _isLoadingCart
            ? SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven
                          ? AppTheme.spinerColor
                          : AppTheme.spinerColor,
                    ),
                  );
                },
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Cart',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 24.0,
                              ),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              child: _isLoading
                                  ? SpinKitFadingCircle(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index.isEven
                                                ? AppTheme.spinerColor
                                                : AppTheme.spinerColor,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      height: deviceHeight * 0.35,
                                      child: foodOrderInfo.FoodOrderInfo
                                                  .FoodOrderDetails.length >
                                              0
                                          ? SingleChildScrollView(
                                              child: ListView.builder(
                                                // controller: _scrollController,
                                                // scrollDirection: Axis.vertical,
                                                itemCount: foodOrderInfo
                                                    .FoodOrderInfo
                                                    .FoodOrderDetails
                                                    .length,
                                                shrinkWrap: true,
                                                primary: false,
                                                padding: EdgeInsets.all(0),
                                                itemBuilder: (ctx, i) =>
                                                    Container(
                                                  width: deviceWidth,
                                                  height: 130,
                                                  child: OrderCartItem(
                                                    food: foodOrderInfo
                                                        .FoodOrderInfo
                                                        .FoodOrderDetails[i],
                                                    fcn: () {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      'You Have No item in List',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.right,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'CircularStd',
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            textScaleFactor *
                                                                16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    )),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'CircularStd',
                                      fontWeight: FontWeight.w600,
                                      fontSize: textScaleFactor * 16.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$${foodOrderInfo.FoodOrderInfo.SubTotalAmount != null ? foodOrderInfo.FoodOrderInfo.SubTotalAmount : 0}',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'CircularStd',
                                      fontWeight: FontWeight.w600,
                                      fontSize: textScaleFactor * 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: InkWell(
                                  onTap: foodOrderInfo.FoodOrderInfo
                                      .FoodOrderDetails.length >
                                      0
                                      ? () async {
                                    await finalizeOrderCart()
                                        .then((value) async {
                                      await Navigator.of(context).pop();
                                      showNotification(
                                          context, value.toString());
                                    });
                                  }:(){},
                                  child: Container(
                                    height: 48,
                                    width: 366,
                                    decoration: BoxDecoration(
                                        color:  foodOrderInfo.FoodOrderInfo
                                            .FoodOrderDetails.length  > 0
                                            ?Colors.black:Colors.grey,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        'Make Order',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    foodList.clear();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    foodGroupList = Provider.of<UserPlans>(context).foodGroupList;

    foodGroupList.map((e) => foodList.addAll(e.Foods)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // height: deviceHeight,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/order_meal_header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              width: deviceWidth,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.01),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimention.topSpace,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Text(
                      'Order Meal',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 24.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                          child: _isLoading
                              ? SpinKitFadingCircle(
                                  itemBuilder: (BuildContext context, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index.isEven
                                            ? AppTheme.spinerColor
                                            : AppTheme.spinerColor,
                                      ),
                                    );
                                  },
                                )
                              : foodGroupList.length > 0
                                  ? ListView(
                            padding: EdgeInsets.all(0),
                            children: foodList
                                .map((e) => Container(
                              width: deviceWidth,
                              height: 130,
                              child: OrderMealItem(
                                food: e,
                              ),
                            )).toList(),
                          )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              'You Have No Diet List',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'CircularStd',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    textScaleFactor * 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            await getOrderCart()
                .then((value) => _settingModalBottomSheet(context));
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
