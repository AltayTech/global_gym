import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/measurment/Measurement.dart';
import 'package:global_gym/screen/measurment/MyMeasurementDetailScreen.dart';
import 'package:global_gym/widget/items/OrderScreenItem.dart';
import 'package:intl/intl.dart' as intl;

class MeasurementItem extends StatelessWidget {
  final Measurement measurement;

  MeasurementItem({
    this.measurement,
  });

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
            MyMeasurementDetailScreen.routeName,
            arguments: {
              'exercise': measurement,
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.date_range),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    formatDate(measurement.LongDate),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CircularStd',
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 16.0,
                    ),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/icons/drawer_menu_measurement.png',
                  height: 20,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    measurement.Weight.toString()+'kg',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CircularStd',
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
