import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/ordeMealSelfMade/FoodSelfMade.dart';
import 'package:global_gym/models/orderMeal/FoodCart.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class OrderMealSelfMadeItem extends StatefulWidget {
  final FoodSelfMade food;

  OrderMealSelfMadeItem({this.food});

  @override
  _OrderMealSelfMadeItemState createState() => _OrderMealSelfMadeItemState();
}

class _OrderMealSelfMadeItemState extends State<OrderMealSelfMadeItem> {
  int productCount = 0;
  bool _isLoading = false;

  Future<String> addToCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false).addSelfMadeFoodToCart(foodId);
    print(isSent);
    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> decreaseFromCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false).decreaseSelfMadeFoodToCart(foodId);
    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> removeFromCart(int foodId) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false).removeSelfMadeFoodFromCart(foodId);
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

    if (vm.foodOrderInfo != null && vm.foodOrderInfo.FoodOrderInfo != null) {
      List<FoodCart> foodCart = vm.foodOrderInfo.FoodOrderInfo.FoodOrderDetails;

      if (foodCart.map((e) => e.FoodId).contains(widget.food.Id))
        productCount = vm.foodOrderInfo.FoodOrderInfo.FoodOrderDetails
            .firstWhere((element) => element.FoodId == widget.food.Id)
            .Quantity;
      else
        productCount = 0;
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
                    image: widget.food.PicPath,
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
                              widget.food.Name,
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
                                productCount == 0
                                    ? Container(
                                        height: 40,
                                        width: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                                child: InkWell(
                                              onTap: () async {
                                                addToCart(widget.food.Id);
                                              },
                                              child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2),
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.grey.withOpacity(0.5))),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  )),
                                            )),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        color: Colors.amber,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (productCount > 1)
                                                    decreaseFromCart(widget.food.Id);
                                                  else
                                                    removeFromCart(widget.food.Id);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  child: Icon(
                                                    Icons.remove,
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
                                                addToCart(widget.food.Id);
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
                                        ),
                                      )
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
                            color: index.isEven ? AppTheme.spinerColor : AppTheme.spinerColor,
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
