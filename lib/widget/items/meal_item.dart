import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/screen/my_diet_detail_screen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem({this.meal});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: LayoutBuilder(
        builder: (context, constraint) => InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              MyDietDetailScreen.routeName,
              arguments: {
                'meal': meal,
              },
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.bg,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(1),
                  blurRadius: 10.10,
                  spreadRadius: 5.510,
                  offset: Offset(
                    0,
                    0,
                  ),
                )
              ],
              borderRadius: new BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${meal.MealName}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Iransans',
                            fontWeight: FontWeight.w500,
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8,right:8),
                        child: Icon(
                          Icons.donut_large,
                          size: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 0, top: 1, bottom: 4),
                        child: Icon(Icons.timer),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 0, top: 1, bottom: 4),
                        child: Text(
                          meal.Time,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Iransans',
                            color: AppTheme.grey,
                            fontSize: textScaleFactor * 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 120,
                    height: 30,
                    child: ListView.builder(
                      // controller: _scrollController,
                      // scrollDirection: Axis.vertical,
                      itemCount: meal.Nuitritions.length,
                      padding: EdgeInsets.all(0),

                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: meal.Nuitritions[i],
                        child: Container(width: 30, height: 30, child: Image.network(meal.Nuitritions[i].PicPath)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
