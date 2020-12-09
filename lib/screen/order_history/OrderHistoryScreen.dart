import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/orderMeal/FoodGroup.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';
import 'package:global_gym/models/orderMeal/Order.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_history/history_cart_screen.dart';
import 'package:global_gym/screen/order_meal/cart_screen.dart';
import 'package:global_gym/widget/items/OrderScreenItem.dart';
import 'package:global_gym/widget/items/order_cart_item.dart';
import 'package:global_gym/widget/items/order_meal_item.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const routeName = '/OrderHistoryScreen';

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _isInit = true;

  var _isLoading = false;

  var _isLoadingCart = false;

  String token;

  String _snackBarMessage = '';

  List<Order> orderList = [];
  final PanelController panelController = PanelController();

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getOrderList().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          orderList =
              Provider.of<UserPlans>(context, listen: false).orderList;
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

  Future<String> getOrderList() async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .getOrderList()
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
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    orderList = Provider.of<UserPlans>(context).orderList;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            // height: deviceHeight,
            width: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  height: 250,
                  width: deviceWidth,
                  child: Image.asset(
                    'assets/images/order_history_header_2.png',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                        child: Text(
                          'Order History',
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
                                  : Container(
                                      child: orderList.length > 0
                                          ? ListView.builder(
                                            // controller: _scrollController,
                                            // scrollDirection: Axis.vertical,
                                            itemCount: orderList.length,
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: EdgeInsets.all(0),
                                            itemBuilder: (ctx, i) =>
                                                Container(
                                                  width: deviceWidth,
                                                  height: 130,
                                                  child: OrderScreenItem(
                                                    order: orderList[i],
                                                    onPressed:() async {
                                                      panelController.open();
                                                      await Provider.of<UserPlans>(context, listen: false).getHistoryOrderDetails(orderList[i].Id);
                                                    }
                                                  ),
                                                ),
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
          SlidingUpPanel(
              backdropEnabled: true,
              isDraggable: false,
              // panelSnapping: false,
              controller: panelController,
              maxHeight: getPercentsOfHeight(context, 70),
              minHeight: 0,
              panel: HistoryCartScreen(
                panelController: panelController,
              ))
        ],
      ),
      // floatingActionButton: Builder(
      //   builder: (context) => FloatingActionButton(
      //     onPressed: () async {
      //       await getOrderCart()
      //           .then((value) => _settingModalBottomSheet(context));
      //     },
      //     backgroundColor: Colors.black,
      //     child: Icon(
      //       Icons.shopping_cart_outlined,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}
