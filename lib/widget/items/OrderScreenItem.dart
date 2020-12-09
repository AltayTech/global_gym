import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/models/orderMeal/Order.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreenItem extends StatelessWidget {
  final Order order;
  final Function onPressed;

  OrderScreenItem({this.order, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var currencyFormat = intl.NumberFormat.decimalPattern();

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppTheme.white,
            border: Border.all(width: 0.3, color: AppTheme.grey),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StringDataRow(
                      title: "Status",
                      amount: order.OrderStatusTypeName.toString(),
                      dimension: '',
                    ),
                  ),
                  Expanded(
                    child: StringDataRow(
                      title: "Total Cost",
                      amount: order.TotalFee.toString(),
                      dimension: '',
                    ),
                  ),
                  Expanded(
                    child: StringDataRow(
                      title: "Payment Type",
                      amount: formatDate(order.FinalizedDateTime),
                      dimension: '',
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String date) {
    var d = date.split(' ');
    return "${d[1]} ${d[2]} ${d[3]}";
  }
}

class StringDataRow extends StatelessWidget {
  const StringDataRow({
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
