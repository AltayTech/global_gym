import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

import '../../provider/app_theme.dart';

class AppointmentItem extends StatelessWidget {
  final Reserve reserve;

  AppointmentItem({this.reserve});

  @override
  Widget build(BuildContext context) {
    var heightDevice = getHeight(context);
    var widthDevice = getWidth(context);
    var textScaleFactor = getTextScaleFactor(context);
    var currencyFormat = intl.NumberFormat.decimalPattern();
    final DateFormat formatterCreate = DateFormat('yyyy/MM/dd');
    DateTime date = formatterCreate.parse(reserve.Date);
    debugPrint(date.toString());

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: LayoutBuilder(
        builder: (context, constraint) => InkWell(
          // onTap: () {
          //   Navigator.of(context).pushNamed(
          //     MyDietDetailScreen.routeName,
          //     arguments: {
          //       'meal': reserve,
          //     },
          //   );
          // },
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
                        child: Text(
                          '${intl.DateFormat.MMMMd().format(date)}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              height: 4,
                              width: 4,
                              decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 0, top: 1, bottom: 4),
                        child: Icon(Icons.timer),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 0, top: 1, bottom: 4),
                        child: Text(
                          '${reserve.FromTime} - ${reserve.ToTime}',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isPast() {
    final DateFormat formatterCreate = DateFormat('yyyy/MM/dd');
    DateTime date = formatterCreate.parse(reserve.Date);

    if (date.isBefore(DateTime.now())) {
      return true;
    } else if (reserve.FromTime.contains(":")) {
      List time = reserve.FromTime.split(":");
      DateTime reserveTime = DateTime(0, 0, 0, int.parse(time[0]), int.parse(time[1]), 0, 0, 0);
      DateTime now = DateTime(0, 0, 0, DateTime.now().hour, DateTime.now().minute, 0, 0, 0);
      return reserveTime.isBefore(now);
    } else
      return true;
  }
}
