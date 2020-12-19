import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/models/Dashboard.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/models/exercise.dart';
import 'package:global_gym/models/meal.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/QRCodeScreen.dart';
import 'package:global_gym/screen/appointment/my_appointment_screen.dart';
import 'package:global_gym/widget/items/dashboard_item.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:global_gym/widget/items/snake_bar.dart';
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

    await _fetchDashboardInfo().then((value) async {
      if (value == 'true') {
        print(value.toString());

        dashboardInfo = Provider.of<UserInfo>(context, listen: false).dashboardInfo;
      } else {
        SnakeBar.show(context, message: value);
      }
    });

    return dashboardInfo;
  }

  Future<String> _fetchDashboardInfo() async {
    String isSent = await Provider.of<UserInfo>(context, listen: false).getDashboardInfo();

    return isSent;
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
      body: FutureBuilder(
        future: _getDashboardInfo,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                      ),
                      DashBoardItem(
                        title: 'Upcoming Exercises ',
                        header: DateFormat.EEEE().format(DateTime.now()),
                        name:dashboardInfo.UserTraningPrograms.firstWhere(
                                (element) => element.WeekDayId == DateTime.now().weekday, orElse: (){
                          return Exercise(ExerciseGroupName: "No Training Program ");
                        }).ExerciseGroupName,
                        iconImage: Image.asset(
                          'assets/icons/measurement_workout.png',
                          height: 30,
                          width: 30,
                          color: Colors.amber,
                        ),
                        image: Image.asset(
                          'assets/images/home_page_pic_1.png',
                          fit: BoxFit.cover,
                        ),
                        fcn: openExercises,
                      ),
                      DashBoardItem(
                        title: 'Upcoming Meal',
                        header: DateFormat.Hm().format(DateTime.now()),
                        name:  dashboardInfo.UserDiets.firstWhere((e) {
                          var t;
                          if(e.Time.contains(":"))
                             t = e.Time.split(":");
                          else t=["00","00"];

                          var time = DateTime(0,0,0,int.parse(t[0]),int.parse(t[1]),0);
                          var now = DateTime(0,0,0, DateTime.now().hour, DateTime.now().minute,0);

                          return time.isAfter(now);
                        }, orElse: (){return Meal(Time: "No Any Diet Today");}).Time,
                        iconImage: Image.asset(
                          'assets/icons/drawer_menu_diet.png',
                          height: 30,
                          width: 30,
                          color: Colors.amber,
                        ),
                        image: Image.asset(
                          'assets/images/home_page_pic_2.png',
                          fit: BoxFit.cover,
                        ),
                        fcn: openMeal,
                      ),
                      DashBoardItem(
                        title: 'Upcoming Events',
                        header: DateFormat.MMMd().format(DateTime.now()),
                        name: UpcomingEvent(dashboardInfo.UserReserves),
                        iconImage: Image.asset(
                          'assets/icons/measurement_weight.png',
                          height: 30,
                          width: 30,
                          color: Colors.amber,
                        ),
                        image: Image.asset(
                          'assets/images/home_page_pic_3.png',
                          fit: BoxFit.cover,
                        ),
                        fcn: openEvent,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container(child: Center(child: Text("Network Error!")));
            }
          else return ProgressWidget();
        },
      ),

      drawer: MainDrawer(dashboard: Provider.of<UserInfo>(context).dashboardInfo,),
    );
  }

   String UpcomingEvent(List<Reserve> userReserves) {
    
    var fromTime = userReserves.firstWhere((element) {
      var d;
      var t;
      if(element.Date.contains("/"))
        d = element.Date.split("/");
      else d= ["0","0","0"];
      if(element.FromTime.contains(":"))
       t = element.FromTime.split(":");
      else t=["0","0"];

      var date = DateTime(int.parse(d[0]),int.parse(d[1]),int.parse(d[2]),int.parse(t[0]), int.parse(t[1]), 0 ,0,0);
      
      return date.isAfter(DateTime.now());
    }, orElse: (){return Reserve();}
    ).FromTime;

    var toTime = userReserves.firstWhere((element) {
      var d;
      var t;
      if(element.Date.contains("/"))
        d = element.Date.split("/");
      else d= ["0000","00","00"];
      if(element.ToTime.contains(":"))
        t = element.ToTime.split(":");
      else t=["00","00"];

      var date = DateTime(int.parse(d[0]),int.parse(d[1]),int.parse(d[2]),int.parse(t[0]), int.parse(t[1]), 0 ,0,0);

      return date.isAfter(DateTime.now());
    },orElse: (){return Reserve();}).ToTime;

    if(fromTime!=null && toTime!=null)
    return fromTime+" - "+toTime;
    else return "No Reserve For Today";
    
  }

}
