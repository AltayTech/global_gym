import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/measurment/Measurement.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/MeasurementItem.dart';
import 'package:provider/provider.dart';

class MyMeasurementScreen extends StatefulWidget {
  static const routeName = '/MyMeasurementScreen';

  @override
  _MyMeasurementScreenState createState() => _MyMeasurementScreenState();
}

class _MyMeasurementScreenState extends State<MyMeasurementScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  List<Measurement> measurementList = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getMeasurementList().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          measurementList =
              Provider.of<UserPlans>(context, listen: false).measurementList;
        } else {
          print('dsfsdssssssssssssssssssss');

          _snackBarMessage = value;
          showNotification(context, _snackBarMessage);
        }
      });

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<String> getMeasurementList() async {
    _isLoading = true;
    setState(() {});

    String isSent =
        await Provider.of<UserPlans>(context, listen: false).getMeasurement();

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<void> showNotification(BuildContext ctx, String message) async {
    Builder(
      builder: (context) {
        SnackBar addToCartSnackBar = SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CircularStd',
              fontSize: 14.0,
            ),
          ),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        Scaffold.of(context).showSnackBar(addToCartSnackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    measurementList = Provider.of<UserPlans>(context).measurementList;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/measurement_header_pic.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              width: deviceWidth,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.01),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Text(
                      'My Measurement',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      child: _isLoading
                          ? SpinKitFadingCircle(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index.isEven
                                        ? AppTheme.spinerColor
                                        : AppTheme.spinerColor,
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: deviceHeight * 0.67,
                              child: measurementList.length > 0
                                  ? ListView.builder(
                                      // controller: _scrollController,
                                      // scrollDirection: Axis.vertical,
                                      itemCount: measurementList.length,
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (ctx, i) =>
                                          ChangeNotifierProvider.value(
                                        value: measurementList[i],
                                        child: Container(
                                          width: deviceWidth,
                                          child: MeasurementItem(
                                            measurement: measurementList[i],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              'You Have No Diet List',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'CircularStd',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    textScaleFactor * 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
