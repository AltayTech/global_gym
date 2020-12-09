import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/exercise.dart';
import 'package:global_gym/provider/app_theme.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;

  ExerciseItem({
    this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = getHeight(context);
    var deviceWidth = getWidth(context);
    var textScaleFactor = getTextScaleFactor(context);

   return Container(
          width: deviceWidth,
          height: 80,
     child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppTheme.white,
              border: Border.all(width: 0.3, color: AppTheme.grey),
            ),
            child: Row(
              children: [
                Center(
                  child: Container(
                    width: 3,
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, right: 4, ),
                    child: Container(
                      height: constraints.maxHeight * 0.7,
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Container(
                              width: constraints.maxHeight * 0.7,
                              height: constraints.maxHeight * 0.7,
                              child: Image.asset(
                                'assets/images/my_exercise_header_pic.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exercise.ExerciseName,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.black,
                                    fontSize: textScaleFactor * 16.0,
                                  ),
                                ),
                                Container(
                                  // color: Colors.green,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DataRow(
                                            title: "sets",
                                            amount: exercise.Sets.toString(),
                                            icon: Image.asset(
                                              'assets/icons/exercise_item_ic_1.png',
                                              fit: BoxFit.cover,
                                              height: 15,
                                            ),
                                            dimension: 'g',
                                          ),
                                        ),
                                        Expanded(
                                          child: DataRow(
                                            title: "reps",
                                            amount: exercise.Reps.toString(),
                                            icon: Image.asset(
                                              'assets/icons/exercise_item_ic_2.png',
                                              fit: BoxFit.cover,
                                              height: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.yellow,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DataRow(
                                            title: "tempo",
                                            amount: exercise.Tempo.toString(),
                                            icon: Image.asset(
                                              'assets/icons/exercise_item_ic_3.png',
                                              fit: BoxFit.cover,
                                              height: 15,
                                            ),
                                            dimension: 'g',
                                          ),
                                        ),
                                        Expanded(
                                          child: DataRow(
                                            title: "breaks",
                                            amount: exercise.Breaks.toString(),
                                            icon: Image.asset(
                                              'assets/icons/exercise_item_ic_4.png',
                                              fit: BoxFit.cover,
                                              height: 15,
                                            ),
                                            dimension: 'min',
                                          ),
                                        ),
                                      ],
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
                ),
              ],
            ),
          );
        },
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
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 0),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 0),
          child: Text(
            '$amount ${dimension != null ? dimension : ''}',
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: AppTheme.black,
              fontSize: textScaleFactor * 12.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 0),
          child: Text(
            title,
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
    );
  }
}
