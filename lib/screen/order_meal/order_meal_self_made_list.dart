import 'package:flutter/material.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/orderMeal/Food.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_meal/cart_screen.dart';
import 'package:global_gym/screen/order_meal/cart_screen_self_made.dart';
import 'package:global_gym/screen/order_meal/order_meal_pre_made.dart';
import 'package:global_gym/screen/order_meal/order_meal_selfe_made.dart';
import 'package:global_gym/widget/items/order_meal_item.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderMealSelfMadeList extends StatefulWidget {
  static const routeName = '/OrderMealSelfMadeList';

  @override
  _OrderMealSelfMadeListState createState() => _OrderMealSelfMadeListState();
}

class _OrderMealSelfMadeListState extends State<OrderMealSelfMadeList> {
  bool _isInit = true;

  var _isLoading = false;

  String token;

  String _snackBarMessage = '';

  final PanelController panelController = PanelController();

  bool hideFAB = false;

  @override
  void initState() {
    Provider.of<UserPlans>(context, listen: false).getFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final vm = Provider.of<UserPlans>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      OrderMealSelfMade.routeName,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/self_made_refresh.png',
                    fit: BoxFit.cover,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      OrderMealPreMade.routeName,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/pre_made.png',
                    fit: BoxFit.cover,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),

          ],
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
                      padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                      child: Text(
                        'Self Made',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          color: Colors.amber,
                          fontWeight: FontWeight.w500,
                          fontSize: textScaleFactor * 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
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
                          padding: const EdgeInsets.only(left: 16, right: 16), child: buildContent(context, vm)),
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
                  panel: CartScreenSelfMade(
                    panelController: panelController,
                  ))
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

  Widget buildContent(BuildContext context, UserPlans vm) {
    if (vm.foodGroupList == null || vm.foodOrderInfo == null)
      return ProgressWidget();
    else {
      List<Food> foodList = [];
      vm.foodGroupList.map((e) => foodList.addAll(e.Foods)).toList();

      return Container(
        child: _isLoading
            ? ProgressWidget()
            : vm.foodGroupList.length > 0
                ? ListView.builder(
                    itemCount: foodList.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: getWidth(context),
                        height: 130,
                        child: OrderMealItem(
                          food: foodList[index],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'You Have No Diet List',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: getTextScaleFactor(context) * 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      );
    }
  }
}
