import 'package:flutter/material.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/screen/home_screen.dart';
import 'package:global_gym/screen/user_profile/user_login_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_email_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  bool _isInit = true;

  var _isLoading;

  String token;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Auth>(context, listen: false).getToken();

      token = Provider.of<Auth>(context, listen: false).token;

      if (token != null && token != '') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName, (Route<dynamic> route) => false);
      }

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 350,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/splash_header_pic.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              width: deviceWidth,
              height: 350,
              child: Container(
                height: 350,
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
              top: 300,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 90,
                    width: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Global GYM',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w800,
                        fontSize: textScaleFactor * 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Welcome to Our Community',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w400,
                        fontSize: textScaleFactor * 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(UserLoginScreen.routeName);
                      },
                      child: Container(

                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Login',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CircularStd',
                              fontWeight: FontWeight.w800,
                              fontSize: textScaleFactor * 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(UserRegisterEmailScreen.routeName);
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'CircularStd',
                              fontWeight: FontWeight.w800,
                              fontSize: textScaleFactor * 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Version 1.0.0',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w400,
                        fontSize: textScaleFactor * 12.0,
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
