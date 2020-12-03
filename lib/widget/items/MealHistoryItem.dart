import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/models/exercise.dart';
import 'package:global_gym/models/orderMeal/Order.dart';
import 'package:global_gym/provider/app_theme.dart';

class MealHistoryItem extends StatelessWidget {
  final Order order;

  MealHistoryItem({
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppTheme.white,
            border: Border.all(width: 0.3, color: AppTheme.grey),
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Container(
                      width: constraints.maxHeight * 0.6,
                      height: constraints.maxHeight * 0.9,
                      child: Image.asset(
                        'assets/images/my_exercise_header_pic.png',
                        fit: BoxFit.cover,
                        height: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
                          child: Text(
                            order.UserFullName,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.black,
                              fontSize: textScaleFactor * 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: DataRow(
                                  title: "sets",
                                  amount: order.FinalizedDateTime.toString(),
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
                                  amount: order.OrderStatusTypeName.toString(),
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
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: DataRow(
                                  title: "tempo",
                                  amount: order.UserFullName.toString(),
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
                                  amount: order.TotalFee.toString(),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
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
          padding: const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
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
