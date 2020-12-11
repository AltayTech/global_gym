import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_gym/models/measurment/Measurement.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

  Timer _timer;

  double textScaleFactor = 1;

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

  var _progressValue = 0.0;

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500),(_timer)
    {
      setState(() {
        if(_progressValue < measurement.ActivityLevel) {
          _progressValue++;
          if(_progressValue==measurement.ActivityLevel)
            _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    measurementFactorsWidget(imageName: "measurement_weight", amount:  '${measurement.Weight}', label: 'Weight'),
                    Stack(
                      children: [
                        levelProgressWidget(measurement.ActivityLevel),
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 4.0, left: 0, right: 0),
                                  child: Text(
                                    '${_progressValue.toInt()}',
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
                      ],
                    ),
                    measurementFactorsWidget(imageName: "measurement_height", amount: '${measurement.Height}', label: 'Height'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Weight Goal',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8),
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
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    measurementFactorsWidget(imageName: "measurement_clock", amount: '${measurement.WekeUpTime}', label: 'Time To Wakeup',),
                    measurementFactorsWidget(imageName: "measurement_workout", amount: '${measurement.SleepTime}', label:  'Time To Train',),
                    measurementFactorsWidget(imageName: "measurement_sleep", amount: '${measurement.WekeUpTime}', label:  'Time To Sleep',),
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

  Padding measurementFactorsWidget({String imageName, String amount, String label}) {
    return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 0, right: 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4.0, left: 0, right: 0),
                          child: Image.asset(
                            'assets/icons/$imageName.png',
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4.0, left: 0, right: 0),
                          child: Text(
                            amount,
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
                          label,
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
                  );
  }

  levelProgressWidget(int activityLevel) {

    return Container(
      // color: Colors.red,
      height: 130,
      width: 130,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              color: Colors.orange[100],//const Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                color: Colors.orange,
                value: _progressValue*10,
                width: 0.2,
                pointerOffset: 0,
                sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 500,
                  animationType: AnimationType.bounceOut
              )
            ],
          ),
          // Create secondary radial axis for segmented line
          RadialAxis(
            minimum: 0,
            interval: 1,
            maximum: 10,
            showLabels: false,
            showTicks: true,
            showAxisLine: false,
            tickOffset: -0.05,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 0,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1,
            majorTickStyle: MajorTickStyle(
                length: 0.3,
                thickness: 3,
                lengthUnit: GaugeSizeUnit.factor,
                color: Colors.white),
          )
        ],

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
