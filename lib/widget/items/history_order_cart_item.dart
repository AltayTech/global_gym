import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryOrderCartItem extends StatefulWidget {
  final FoodCart food;
  final bool canEdit;

  HistoryOrderCartItem({
    this.food,
    this.canEdit
  });

  @override
  _OrderCartItemState createState() => _OrderCartItemState();
}

class _OrderCartItemState extends State<HistoryOrderCartItem> {
  int productCount = 0;

  bool _isLoading = false;


  Future<String> addToCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .addFoodToHistoryCart(foodId);


    print(isSent);
    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> decreaseFromCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .decreaseFoodToHistoryCart(foodId);


    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> removeFromCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .removeFoodFromHistoryCart(foodId);


    _isLoading = false;
    setState(() {});
    return isSent;
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    final vm = Provider.of<UserPlans>(context);

    if(vm.historyOrderDetails !=null && vm.historyOrderDetails.FoodOrderInfo!=null) {
        productCount = vm.historyOrderDetails.FoodOrderInfo.FoodOrderDetails.firstWhere((element) => element.FoodId == widget.food.FoodId).Quantity;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/meal_item_sample_pic.png',
                    image: widget.food.FoodPicPath,
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.food.FoodName,
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
                          ),
                          Spacer(),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  '\$${widget.food.Fee}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CircularStd',
                                    fontWeight: FontWeight.w300,
                                    fontSize: textScaleFactor * 12.0,
                                  ),
                                ),
                                Spacer(),
                                widget.canEdit ? Container(
                                  height: 40,
                                  width: 100,
                                  color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            if (productCount > 1) {
                                              await decreaseFromCart(
                                                  widget.food.FoodId);
                                            } else {
                                              await removeFromCart(
                                                  widget.food.FoodId);
                                            }

                                            final prefs = await SharedPreferences.getInstance();

                                            var _hashId = prefs.getString('historyHashId');

                                            prefs.setString('hashId', _hashId);

                                            Provider.of<UserPlans>(context, listen: false).historyOrderChanged = true;

                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: Icon(
                                              productCount > 1
                                                  ? Icons.remove
                                                  : Icons.delete,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          productCount.toString(),
                                          style: TextStyle(
                                            color: AppTheme.black,
                                            fontSize: textScaleFactor * 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          await addToCart(widget.food.FoodId);
                                          final prefs = await SharedPreferences.getInstance();

                                          var _hashId = prefs.getString('historyHashId');

                                          prefs.setString('hashId', _hashId);

                                          Provider.of<UserPlans>(context, listen: false).historyOrderChanged = true;

                                        },
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            )),
                                      )),
                                    ],
                                  )
                                ) : Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                      productCount.toString(),
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontSize: textScaleFactor * 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
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
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
