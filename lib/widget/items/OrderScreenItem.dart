import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/models/orderMeal/Order.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreenItem extends StatelessWidget {
  final Order order;

  OrderScreenItem({this.order});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top:8.0
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppTheme.white,
              border: Border.all(width: 0.3, color: AppTheme.grey),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: DataRow(
                        title: "Status",
                        amount: order.OrderStatusTypeName.toString(),
                        dimension: '',
                      ),
                    ),
                    Expanded(
                      child: DataRow(
                        title: "Total Cost",
                        amount: order.TotalFee.toString(),
                        dimension: '',
                      ),
                    ),
                    Expanded(
                      child: DataRow(
                        title: "Payment Type",
                        amount: order.FinalizedDateTime.toString(),
                        dimension: '',
                      ),
                    ),

                  ],
                ),
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
  }) : super(key: key);

  final String title;
  final String amount;
  final String dimension;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
            child: Text(
              title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'CircularStd',
                color: AppTheme.grey,
                fontSize: textScaleFactor * 12.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
            child: Text(
              '$amount ${dimension != null ? dimension : ''}',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'CircularStd',
                color: AppTheme.black,
                fontSize: textScaleFactor * 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
