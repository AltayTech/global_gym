import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/meal_item.dart';
import 'package:provider/provider.dart';

class MyDietScreen extends StatefulWidget {
  static const routeName = '/MyDietScreen';

  @override
  _MyDietScreenState createState() => _MyDietScreenState();
}

class _MyDietScreenState extends State<MyDietScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  List<Meal> listMeal = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getMeals().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          listMeal = Provider.of<UserPlans>(context, listen: false).mealList;
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

  Future<String> getMeals() async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false).getMeals();

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
    listMeal = Provider.of<UserPlans>(context).mealList;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/my_diet_header_pic.png',
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
                      Colors.white.withOpacity(0.01),
                      Colors.white.withOpacity(0.01),
                      Colors.white.withOpacity(0.01),
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
              top: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Text(
                      'My Diet',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                        width: double.infinity,
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
                            : Container(
                          height: deviceHeight*0.6,
                                child: listMeal.length > 0
                                    ? ListView.builder(
                                        // controller: _scrollController,
                                        // scrollDirection: Axis.vertical,
                                        itemCount: listMeal.length,
                                        padding: EdgeInsets.all(0),

                                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                                          value: listMeal[i],
                                          child: Container(
                                            width: deviceWidth,
                                            child: MealItem(
                                              meal: listMeal[i],
                                            ),
                                          ),
                                        ),
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
                                                  fontSize: textScaleFactor * 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
