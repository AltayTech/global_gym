import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/classes/media_query_helper.dart';
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
    var heightDevice = getHeight(context);
    var widthDevice = getWidth(context);
    var textScaleFactor = getTextScaleFactor(context);
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              shape: BoxShape.rectangle,
              color: AppTheme.white,
              border: Border.all(width: 0.3, color: AppTheme.grey),
              borderRadius: new BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 3,
                    color: isPast() ? Colors.grey : Colors.orange,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Expanded(
                          child: Text(
                            '${meal.MealName}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: textScaleFactor * 14.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8,right:8),
                        child: Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                          ),
                        )
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
                      scrollDirection: Axis.horizontal,
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
  bool isPast() {
    if(meal.Time.contains(":")) {
      List time = meal.Time.split(":");
      DateTime mealtime = DateTime(0, 0, 0, int.parse(time[0]), int.parse(time[1]), 0, 0, 0);
      DateTime now = DateTime(0, 0, 0, DateTime.now().hour, DateTime.now().minute, 0, 0, 0);
      return mealtime.isBefore(now);
    } else
      return true;
  }
}


