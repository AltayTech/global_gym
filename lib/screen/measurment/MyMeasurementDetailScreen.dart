import 'package:flutter/material.dart';
import 'package:global_gym/models/measurment/Measurement.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:provider/provider.dart';

class MyMeasurementDetailScreen extends StatefulWidget {
  static const routeName = '/MyMeasurementDetailScreen';

  @override
  _MyMeasurementDetailScreenState createState() =>
      _MyMeasurementDetailScreenState();
}

class _MyMeasurementDetailScreenState extends State<MyMeasurementDetailScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  Measurement measurement;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final Map argument = ModalRoute.of(context).settings.arguments as Map;

      measurement = argument['exercise'];
      await getMeasurementDetail(measurement.Id);
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<String> getMeasurementDetail(int id) async {
    _isLoading = true;
    setState(() {});

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .getMeasurementDetail(id)
        .then((value) {
      if (value == 'true') {
        measurement =
            Provider.of<UserPlans>(context, listen: false).measurementDetail;
        return 'true';
      } else {
        return 'false';
      }
    });

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Image.asset(
                                'assets/icons/measurement_weight.png',
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Text(
                                '${measurement.Weight}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Weight',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Text(
                                '${measurement.ActivityLevel}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Activity Level',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Image.asset(
                                'assets/icons/measurement_height.png',
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Text(
                                '${measurement.Weight}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Weight',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8.0, left: 0, right: 8),
                      child: Text(
                        'Weight Goal',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: textScaleFactor * 12.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8.0, left: 8, right: 0),
                      child: Text(
                        '${measurement.WeightGoal} lbs',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: textScaleFactor * 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Image.asset(
                                'assets/icons/measurement_clock.png',
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '${measurement.WekeUpTime}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Time To Wakeup',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 0, right: 0),
                              child: Image.asset(
                                'assets/icons/measurement_workout.png',
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '${measurement.TrainTime}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Time To Train',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 0, right: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Image.asset(
                                'assets/icons/measurement_sleep.png',
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '${measurement.SleepTime}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Text(
                              'Time To Sleep',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 0, right: 0),
                  child: Text(
                    'Muscle Group',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 0, right: 0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 0, right: 0),
                            child: Text(
                              'Fat Group',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                          MuscleGroup(
                            measurementPoint: 'Chest',
                            measurementQuantity: measurement.Chest,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Triceps',
                            measurementQuantity: measurement.Triceps,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Biceps',
                            measurementQuantity: measurement.Biceps,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Subscap',
                            measurementQuantity: measurement.Subscap,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Midax',
                            measurementQuantity: measurement.Midax,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Suprullic',
                            measurementQuantity: measurement.Suprullic,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Abs',
                            measurementQuantity: measurement.Abs,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Thigh',
                            measurementQuantity: measurement.Thigh,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Hamstring',
                            measurementQuantity: measurement.Hamstring,
                            measurementUnit: 'Decr',
                          ),
                          MuscleGroup(
                            measurementPoint: 'Knee',
                            measurementQuantity: measurement.Knee,
                            measurementUnit: 'Decr',
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
    );
  }
}

class MuscleGroup extends StatelessWidget {
  const MuscleGroup({
    Key key,
    @required this.measurementQuantity,
    @required this.measurementPoint,
    @required this.measurementUnit,
  }) : super(key: key);

  final double measurementQuantity;
  final String measurementPoint;
  final String measurementUnit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 0, right: 0),
                  child: Text(
                    'Measurement Point',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 16, right: 0),
                  child: Text(
                    measurementPoint,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 0, right: 0),
                  child: Text(
                    'Quantity',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 16, right: 0),
                  child: Text(
                    measurementQuantity.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 0, right: 0),
                  child: Text(
                    'Measurement Unit',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 16, right: 0),
                  child: Text(
                    measurementUnit,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
