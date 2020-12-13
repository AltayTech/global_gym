import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/orderMeal/FoodOrderCart.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/history_order_cart_item.dart';
import 'package:global_gym/widget/items/order_cart_item.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:global_gym/widget/items/snake_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HistoryCartScreen extends StatefulWidget {
  final PanelController panelController;

  HistoryCartScreen({@required this.panelController});

  @override
  _HistoryCartScreenState createState() => _HistoryCartScreenState();
}

class _HistoryCartScreenState extends State<HistoryCartScreen> {
  var _isLoadingCart = false;

  bool _hasChanged = false;

  @override
  void initState() {
    Provider.of<UserPlans>(context, listen: false).getOrderCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserPlans>(context);
    return _buildCartContent(context, vm);
  }

  Widget _buildCartContent(context, UserPlans vm) {
    double deviceHeight = getHeight(context);
    double deviceWidth = getWidth(context);
    double textScaleFactor = getTextScaleFactor(context);


    if (vm.historyOrderDetails == null || _isLoadingCart)
      return ProgressWidget();
    else {
      var foodOrderCart = vm.historyOrderDetails;
      return Container(
        padding: EdgeInsets.all(16.0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          widget.panelController.close();
                        },
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: foodOrderCart != null
                      ? foodOrderCart.FoodOrderInfo.FoodOrderDetails.length > 0
                          ? ListView.builder(
                              // controller: _scrollController,
                              // scrollDirection: Axis.vertical,
                              itemCount: foodOrderCart
                                  .FoodOrderInfo.FoodOrderDetails.length,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (ctx, i) => Container(
                                    width: deviceWidth,
                                    height: 130,
                                    child: HistoryOrderCartItem(
                                      food: foodOrderCart
                                          .FoodOrderInfo.FoodOrderDetails[i],
                                      canEdit:
                                          foodOrderCart.OrderStatusTypes == 1
                                              ? true
                                              : false
                                    ),
                                  ))
                          : _emptyWidget(context)
                      : _emptyWidget(context),
                ),
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
                          '${foodOrderCart.FoodOrderInfo != null && foodOrderCart.FoodOrderInfo.SubTotalAmount != null ? foodOrderCart.FoodOrderInfo.SubTotalAmount : 0}',
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
                foodOrderCart.OrderStatusTypes == 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: InkWell(
                          onTap: foodOrderCart != null && vm.historyOrderChanged
                              ? () async {
                                  await finalizeOrderCart().then((value) async {
                                    SnakeBar.show(context, message: value);
                                  });
                                }
                              : () {},
                          child: Container(
                            height: 48,
                            width: 366,
                            decoration: BoxDecoration(
                                color: foodOrderCart != null && vm.historyOrderChanged
                                    ? Colors.black
                                    : Colors.grey,
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(
                                'Save Change',
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
                      )
                    : Container(),
              ],
            ),
          ],
        ),
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

  Future<String> finalizeOrderCart() async {
    _isLoadingCart = true;
    setState(() {});

    final prefs = await SharedPreferences.getInstance();

    var _hashId = prefs.getString('historyHashId');

    prefs.setString('hashId', _hashId);

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .finalizeOrderCart()
        .then((value) {
      if (value == 'true') {
        widget.panelController.close();
        return 'Order is send successfully';
      } else {
        return value;
      }
    });

    _isLoadingCart = false;
    setState(() {});
    return isSent;
  }
}
