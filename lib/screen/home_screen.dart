import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/Dashboard.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/QRCodeScreen.dart';
import 'package:global_gym/screen/appointment/my_appointment_screen.dart';
import 'package:global_gym/widget/items/dashboard_item.dart';
import 'package:global_gym/widget/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'my_diet_Screen.dart';
import 'my_exercise_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;

  var _isLoading = false;

  Dashboard dashboardInfo;

  Future<Dashboard> _getDashboardInfo;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _getDashboardInfo = getDashboardInfo();

      _isInit = false;
      super.didChangeDependencies();
    }
  }

  Future<Dashboard> getDashboardInfo() async {
    setState(() {
      _isLoading = true;
    });

    await _fetchDashboardInfo().then((value) async {
      if (value == 'true') {
        print(value.toString());

        dashboardInfo = Provider.of<UserInfo>(context, listen: false).dashboardInfo;
      } else {
        // showNotification(context, value);
      }
    });
    setState(() {
      _isLoading = false;
    });

    return dashboardInfo;
  }

  Future<String> _fetchDashboardInfo() async {
    String isSent = await Provider.of<UserInfo>(context, listen: false).getDashboardInfo();

    return isSent;
  }

  Future<void> showNotification(BuildContext ctx, String message) async {
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
    Scaffold.of(ctx).showSnackBar(addToCartSnackBar);
  }

  void openExercises() {
    Navigator.of(context).pushNamed(MyExerciseScreen.routeName);
  }

  void openMeal() {
    Navigator.of(context).pushNamed(MyDietScreen.routeName);
  }

  void openEvent() {
    Navigator.of(context).pushNamed(MyAppointmentScreen.routeName);
  }

  void openQRCode() {
    Navigator.of(context).pushNamed(QRCodeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = getHeight(context);
    double deviceWidth = getWidth(context);
    double textScaleFactor = getTextScaleFactor(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                openQRCode();
              },
              child: Image.asset(
                'assets/icons/home_page_qrcode.png',
                width: 30,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: _getDashboardInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 4),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/user_sample_pic.png',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  image: dashboardInfo.CustomerUsers.PersonalPicPath,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0, bottom: 4, left: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome back, ${dashboardInfo.CustomerUsers.FirstName}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontFamily: 'CircularStd',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: textScaleFactor * 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Looks like a good day for a solid workout. Don’t miss a thing',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: 'CircularStd',
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: textScaleFactor * 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  FutureBuilder(
                    future: _getDashboardInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DashBoardItem(
                          title: 'Upcoming Exercises ',
                          header: DateFormat.EEEE().format(DateTime.now()),
                          name: dashboardInfo.UserTraningPrograms.firstWhere(
                              (element) => element.WeekDayId == DateTime.now().weekday).ExerciseGroupName,
                          icon: Icon(
                            Icons.watch,
                            color: Colors.amber,
                          ),
                          image: Image.asset(
                            'assets/images/home_page_pic_1.png',
                            fit: BoxFit.cover,
                          ),
                          fcn: openExercises,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  FutureBuilder(
                    future: _getDashboardInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DashBoardItem(
                          title: 'Upcoming Meal',
                          header: DateFormat.Hm().format(DateTime.now()),
                          name:  dashboardInfo.UserDiets[DateTime.now().weekday].Time,
                          icon: Icon(
                            Icons.watch,
                            color: Colors.amber,
                          ),
                          image: Image.asset(
                            'assets/images/home_page_pic_2.png',
                            fit: BoxFit.cover,
                          ),
                          fcn: openMeal,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  FutureBuilder(
                    future: _getDashboardInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DashBoardItem(
                          title: 'Upcoming Events',
                          header: DateFormat.MMMd().format(DateTime.now()),
                          name: 'Mon 18:00 - 20:00',
                          icon: Icon(
                            Icons.watch,
                            color: Colors.amber,
                          ),
                          image: Image.asset(
                            'assets/images/home_page_pic_3.png',
                            fit: BoxFit.cover,
                          ),
                          fcn: openEvent,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: _isLoading
                  ? SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index.isEven ? AppTheme.spinerColor : AppTheme.spinerColor,
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
          ),
        ],
      ),
      drawer: MainDrawer(dashboard: dashboardInfo,),
    );
  }
}
