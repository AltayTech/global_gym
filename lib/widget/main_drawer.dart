import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/Dashboard.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/screen/BillsScreen.dart';
import 'package:global_gym/screen/appointment/my_appointment_screen.dart';
import 'package:global_gym/screen/measurment/MyMeasurementScreen.dart';
import 'package:global_gym/screen/my_diet_Screen.dart';
import 'package:global_gym/screen/my_exercise_screen.dart';
import 'package:global_gym/screen/order_history/OrderHistoryScreen.dart';
import 'package:global_gym/screen/order_meal/order_meal_pre_made.dart';
import 'package:global_gym/screen/user_profile/user_change_password_screen.dart';
import 'package:global_gym/screen/user_profile/user_forget_screen.dart';
import 'package:global_gym/screen/user_profile/user_membership_screen.dart';
import 'package:global_gym/screen/user_profile/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/app_theme.dart';

class MainDrawer extends StatelessWidget {
  final Dashboard dashboard;


  MainDrawer({this.dashboard});

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Color textColor = Colors.black;
    Color iconColor = AppTheme.grey;

    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:16, right: 16, top: 16),
            child: Container(
              height: 150,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/user_sample_pic.png',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      image: dashboard.CustomerUsers.PersonalPicPath,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      dashboard!=null?'${dashboard.CustomerUsers.FirstName} ${dashboard.CustomerUsers.LastName}':'',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: textScaleFactor * 16,
                          fontFamily: "BFarnaz",
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      await Provider.of<Auth>(context, listen: false)
                          .removeToken();
                      Navigator.of(context).pushNamed('/');
                    },
                    child: Icon(
                      Icons.exit_to_app,
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left:16, right: 16, bottom: 16),
                      child: Text(
                        'My Fitness',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: textScaleFactor * 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'My Exercise',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_exercise.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(MyExerciseScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'My Diet',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16.0,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_diet.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(MyDietScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'My Measurement',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16.0,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_measurement.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () async {
                      Navigator.of(context)
                          .pushNamed(MyMeasurementScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'My Appointment',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Icon(
                      Icons.date_range,
                      color: iconColor,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        MyAppointmentScreen.routeName,
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Order Meal',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 15,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Icon(
                      Icons.fastfood,
                      color: iconColor,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        OrderMealPreMade.routeName,
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: textScaleFactor * 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'My Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_profile.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        UserProfileScreen.routeName,
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Bills',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 16,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_bill.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        BillsScreen.routeName,
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Order History',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 15,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Icon(
                      Icons.timer,
                      color: iconColor,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        OrderHistoryScreen.routeName,
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 15,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Image.asset(
                      'assets/icons/drawer_menu_change_pass.png',
                      height: 20,
                      color: Colors.black45,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        UserChangePasswordScreen.routeName,
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Text(
                  //     'Meal',
                  //     style: TextStyle(
                  //       fontFamily: 'Iransans',
                  //       fontSize: textScaleFactor * 15.0,
                  //       color: textColor,
                  //     ),
                  //     textAlign: TextAlign.left,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.power_settings_new,
                  //     color: iconColor,
                  //   ),
                  //   onTap: () async {
                  //     await Provider.of<Auth>(context, listen: false)
                  //         .removeToken();
                  //     Navigator.of(context).pushNamed('/');
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
