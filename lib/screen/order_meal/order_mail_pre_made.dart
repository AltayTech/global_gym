import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/orderMeal/Food.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_meal/cart_screen.dart';
import 'package:global_gym/widget/items/order_cart_item.dart';
import 'package:global_gym/widget/items/order_meal_item.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderMealPreMade extends StatefulWidget {
  static const routeName = '/OrderMealPreMade';

  @override
  _OrderMealPreMadeState createState() => _OrderMealPreMadeState();
}

class _OrderMealPreMadeState extends State<OrderMealPreMade> {
  bool _isInit = true;

  var _isLoading = false;

  String token;

  String _snackBarMessage = '';

  List<FoodGroup> foodGroupList = [];


  final PanelController panelController = PanelController();

  bool hideFAB = false;

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

  @override
  Widget build(BuildContext context) {
    List<Food> foodList = [];
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
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 16, right: 16),
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
                                                ))
                                            .toList(),
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
              SlidingUpPanel(
                  onPanelClosed: () {
                    setState(() {
                      hideFAB = false;
                    });
                  },
                  onPanelOpened: () {
                    setState(() {
                      hideFAB = true;
                    });
                  },
                  backdropEnabled: true,
                  isDraggable: false,
                  // panelSnapping: false,
                  controller: panelController,
                  maxHeight: getPercentsOfHeight(context, 70),
                  minHeight: 0,
                  panel: CartScreen())
            ],
          ),
        ),
        floatingActionButton: hideFAB
            ? null
            : FloatingActionButton(
                onPressed: () async {

                  panelController.open();
                },
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ));
  }
}
