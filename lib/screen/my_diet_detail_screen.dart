import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/widget/items/nutrition_item.dart';
import 'package:provider/provider.dart';

class MyDietDetailScreen extends StatefulWidget {
  static const routeName = '/MyDietDetailScreen';

  @override
  _MyDietDetailScreenState createState() => _MyDietDetailScreenState();
}

class _MyDietDetailScreenState extends State<MyDietDetailScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  Meal meal;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final Map argument = ModalRoute.of(context).settings.arguments as Map;

      meal = argument['meal'];

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          meal.MealName,
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: Colors.black,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                meal.Time,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: textScaleFactor * 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
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
                                : meal.Nuitritions.length > 0
                                    ? Container(
                                        width: double.infinity,
                                        height: 380,
                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: meal.Nuitritions.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                                            value: meal.Nuitritions[i],
                                            child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 100,
                                                  child: NutritionItem(
                                                    nutrition: meal.Nuitritions[i],
                                                  ),
                                                )),
                                          ),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 1,
                                              mainAxisSpacing: 10),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DataRow(
                            title: "Weight",
                            amount: meal.SumOfCarbs.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_weight.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                            dimension: 'g',
                          ),
                        ),
                        Expanded(
                          child: DataRow(
                            title: "Quantity",
                            amount: meal.SumOfFat.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_quantity.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DataRow(
                            title: "Carbs",
                            amount: meal.SumOfCarbs.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_carbs.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                            dimension: 'g',
                          ),
                        ),
                        Expanded(
                          child: DataRow(
                            title: "Fat",
                            amount: meal.SumOfFat.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_fat.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                            dimension: '%',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DataRow(
                            title: "Protein",
                            amount: meal.SumOfProtein.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_protein.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                            dimension: 'g',
                          ),
                        ),
                        Expanded(
                          child: DataRow(
                            title: "Calories",
                            amount: meal.SumOfCalories.toString(),
                            icon: Image.asset(
                              'assets/images/my_diet_calories.png',
                              fit: BoxFit.cover,
                              height: 20,
                            ),
                            dimension: 'kcal',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  const DataRow({
    Key key,
    @required this.title,
    @required this.amount,
    this.dimension,
    this.icon,
  }) : super(key: key);

  final String title;
  final String amount;
  final String dimension;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 0, top: 1, bottom: 4),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 0, top: 1, bottom: 4),
          child: Text(
            title,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: AppTheme.grey,
              fontSize: textScaleFactor * 12.0,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 24, left: 0, top: 1, bottom: 4),
          child: Text(
            '$amount ${dimension != null ? dimension : ''}',
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: AppTheme.black,
              fontSize: textScaleFactor * 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
