import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodSelfMade.dart';
import 'package:global_gym/models/orderMeal/Food.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/order_meal/order_meal_pre_made.dart';
import 'package:global_gym/screen/order_meal/order_meal_selfe_made.dart';
import 'package:global_gym/widget/items/OrderMealSelfMadeItem.dart';
import 'package:global_gym/widget/items/order_cart_item.dart';
import 'package:global_gym/widget/items/order_meal_item.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:global_gym/widget/items/snake_bar.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderMealSelfMadeList extends StatefulWidget {
  static const routeName = '/OrderMealSelfMadeList';

  @override
  _OrderMealSelfMadeListState createState() => _OrderMealSelfMadeListState();
}

class _OrderMealSelfMadeListState extends State<OrderMealSelfMadeList> {

  String token;

  final PanelController panelController = PanelController();

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
                onTap: () async {
                  await clearSelectedSelfAndSelfCart(context);
                  Navigator.of(context).pushReplacementNamed(
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
                  Navigator.of(context).pop();
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
                      child: buildContent(
                        context,
                        vm,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'CircularStd',
                            fontWeight: FontWeight.w600,
                            fontSize: textScaleFactor * 16.0,
                          ),
                        ),
                        Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$',
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w600,
                                fontSize: textScaleFactor * 13.0,
                              ),
                            ),
                            Text(
                              '${vm.selfMadeFoodOrderCard.FoodOrderInfo != null && vm.selfMadeFoodOrderCard.FoodOrderInfo.SubTotalAmount != null ? vm.selfMadeFoodOrderCard.FoodOrderInfo.SubTotalAmount : 0}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w600,
                                fontSize: textScaleFactor * 18.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: InkWell(
                      onTap:
                      vm.selfMadeFoodOrderCard.FoodOrderInfo != null && vm.selfMadeFoodOrderCard.FoodOrderInfo.FoodOrderDetails.length > 0
                          ? () async {
                        await finalizeSelfMadeOrderCart().then((value) async {
                          Navigator.of(context).pushReplacementNamed(OrderMealPreMade.routeName);

                          SnakeBar.show(context, message: value);
                        });
                      }
                          : () {},
                      child: Container(
                        height: 48,
                        width: 366,
                        decoration: BoxDecoration(
                            color: vm.selfMadeFoodOrderCard.FoodOrderInfo != null &&
                                vm.selfMadeFoodOrderCard.FoodOrderInfo.FoodOrderDetails.length > 0
                                ? Colors.black
                                : Colors.grey,
                            border: Border.all(color: Colors.black)),
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
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, UserPlans vm) {
    if (vm.selfMadeFoodOrderCard == null && vm.selfMadeFoodOrderCard.FoodOrderInfo == null)
      return ProgressWidget();
    else {
      return Container(
        child: vm.selfMadeFoodOrderCard.FoodOrderInfo.FoodOrderDetails.length > 0
            ? ListView.builder(
                itemCount: vm.selfMadeFoodOrderCard.FoodOrderInfo.FoodOrderDetails.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (ctx, index) {
                  return Container(
                    width: getWidth(context),
                    height: 130,
                    child: OrderMealSelfMadeItem(
                      food: vm.selfMadeFoodOrderCard.FoodOrderInfo.FoodOrderDetails[index],
                    ),
                  );
                },
              )
            : _emptyWidget(context)
      );
    }
  }


  Widget _emptyWidget(BuildContext context) {
    double textScaleFactor = getTextScaleFactor(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'You Have No item in List',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: textScaleFactor * 16.0,
          ),
        ),
      ),
    );
  }

  Future<String> finalizeSelfMadeOrderCart() async {

    String isSent = await Provider.of<UserPlans>(context, listen: false).finalizeSelfMadeOrderCart().then((value) {
      if (value == 'true') {
        return 'Self Made Order is send successfully';
      } else {
        return value;
      }
    });
    return isSent;
  }
}
