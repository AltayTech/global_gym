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

    var htmlcode ="""
    <p dir="rtl">جواب <math xmlns="http://www.w3.org/1998/Math/MathML"><msqrt><mn>&#1784;</mn></msqrt></math> چیست؟</p>
    """;
    var htmlcode2 ="""
    <p>جواب سوال&nbsp;<span class="MathJax_Preview" style="color: inherit; display: none;"></span><span class="MathJax" id="MathJax-Element-1-Frame" tabindex="0" style="position: relative;" data-mathml="<math xmlns=&quot;http://www.w3.org/1998/Math/MathML&quot;><mroot><mrow><mn>&amp;#x6F2;&amp;#x6F5;</mn><mo>&amp;#xA0;</mo><mi>x</mi></mrow><mn>&amp;#x6F3;</mn></mroot></math>" role="presentation"><nobr aria-hidden="true"><span class="math" id="MathJax-Span-1" style="display: inline-block; width: 3.235em;"><span style="display: inline-block; position: relative; width: 2.718em; height: 0px; font-size: 119%;"><span style="position: absolute; clip: rect(1.49em, 1002.72em, 3.106em, -999.997em); top: -2.582em; left: 0em;"><span class="mrow" id="MathJax-Span-2" style="display: inline-block;"><span class="mroot" id="MathJax-Span-3" style="display: inline-block;"><span style="display: inline-block; position: relative; width: 2.718em; height: 0px;"><span style="position: absolute; clip: rect(1.619em, 1001.68em, 2.977em, -999.997em); top: -2.582em; left: 0.973em;"><span class="mrow" id="MathJax-Span-4" style="display: inline-block;"><span class="mn" id="MathJax-Span-5" style="display: inline-block;"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 84%; font-style: normal; font-weight: normal;">۲</span><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 84%; font-style: normal; font-weight: normal;">۵</span></span><span class="mo" id="MathJax-Span-6" style="display: inline-block;"><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Main/Regular/336/00A0.png?V=2.7.0" style="width: 0px; height: 0px; margin-right: 0.262em;"></span><span class="mi" id="MathJax-Span-7" style="display: inline-block;"><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Math/Italic/336/0078.png?V=2.7.0" style="width: 8px; height: 7px; vertical-align: 0px; margin-right: 0.068em;"></span></span><span style="display: inline-block; width: 0px; height: 2.589em;"></span></span><span style="position: absolute; clip: rect(3.559em, 1001.75em, 3.946em, -999.997em); top: -4.586em; left: 0.973em;"><span style="display: inline-block; position: relative; width: 1.749em; height: 0px;"><span style="position: absolute; top: -4.005em; left: -0.061em;"><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Main/Regular/336/2212.png?V=2.7.0" style="width: 11px; height: 1px; vertical-align: 3px; margin-right: 0.068em;"><span style="display: inline-block; width: 0px; height: 4.011em;"></span></span><span style="position: absolute; top: -4.005em; left: 1.102em;"><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Main/Regular/336/2212.png?V=2.7.0" style="width: 11px; height: 1px; vertical-align: 3px; margin-right: 0.068em;"><span style="display: inline-block; width: 0px; height: 4.011em;"></span></span><span style="position: absolute; top: -4.005em; left: 0.456em;"><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Main/Regular/336/2212.png?V=2.7.0" style="width: 11px; height: 1px; vertical-align: 3px; margin-right: 0.068em;"><span style="display: inline-block; width: 0px; height: 4.011em;"></span></span></span><span style="display: inline-block; width: 0px; height: 4.011em;"></span></span><span style="position: absolute; clip: rect(2.977em, 1001.04em, 4.528em, -999.997em); top: -4.069em; left: 0em;"><span><img src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/fonts/HTML-CSS/TeX/png/Size1/Regular/336/221A.png?V=2.7.0" style="width: 16px; height: 19px; vertical-align: -6px; margin-right: 0.003em;"></span><span style="display: inline-block; width: 0px; height: 4.011em;"></span></span><span style="position: absolute; clip: rect(2.007em, 1000.26em, 2.912em, -999.997em); top: -3.035em; left: 0.391em;"><span class="mn" id="MathJax-Span-8" style="display: inline-block; font-size: 51.7%;"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 84%; font-style: normal; font-weight: normal;">۳</span></span><span style="display: inline-block; width: 0px; height: 2.589em;"></span></span></span></span></span><span style="display: inline-block; width: 0px; height: 2.589em;"></span></span></span><span style="display: inline-block; overflow: hidden; vertical-align: -0.458em; border-left: 0px solid; width: 0px; height: 1.619em;"></span></span></nobr><span class="MJX_Assistive_MathML" role="presentation"><math xmlns="http://www.w3.org/1998/Math/MathML"><mroot><mrow><mn>۲۵</mn><mo>&nbsp;</mo><mi>x</mi></mrow><mn>۳</mn></mroot></math></span></span><script type="math/mml" id="MathJax-Element-1"><math xmlns="http://www.w3.org/1998/Math/MathML"><mroot><mrow><mn>۲۵</mn><mo>&nbsp;</mo><mi>x</mi></mrow><mn>۳</mn></mroot></math></script>&nbsp;چیست ؟&nbsp;</p>
    """;

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
