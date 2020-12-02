import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/week_day_exercise.dart';
import 'package:global_gym/screen/my_exercise_detail_screen.dart';
import 'package:intl/intl.dart' as intl;

class WeekDayExerciseItem extends StatelessWidget {
  final WeekDayExercises weekDayExercise;

  WeekDayExerciseItem({this.weekDayExercise});

  String getWeekDayImage(int weekday) {
    List<String> weekdaysImage = [
      'assets/images/exercise_item_monday.png',
      'assets/images/exercise_item_tuesday.png',
      'assets/images/exercise_item_wednesday.png',
      'assets/images/exercise_item_thursday.png',
      'assets/images/exercise_item_friday.png',
      'assets/images/exercise_item_saturday.png',
      'assets/images/exercise_item_sunday.png',
    ];

    return weekdaysImage[weekday];
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            MyExerciseDetailScreen.routeName,
            arguments: {
              'exercise': weekDayExercise,
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: 130,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  getWeekDayImage(weekDayExercise.WeekDayId - 1),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.white.withOpacity(0.00),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weekDayExercise.WeekDayName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'CircularStd',
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 16.0,
                        ),
                      ),
                      Text(
                        'View Details',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'CircularStd',
                          fontWeight: FontWeight.w300,
                          fontSize: textScaleFactor * 12.0,
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
    );
  }
}
