import 'package:flutter/material.dart';
import 'package:global_gym/screen/survey_screen.dart';
import 'package:global_gym/screen/user_profile/user_login_screen.dart';

class UserRegisterCompletionScreen extends StatefulWidget {
  static const routeName = '/UserRegisterCompletionScreen';

  @override
  _UserRegisterCompletionScreenState createState() =>
      _UserRegisterCompletionScreenState();
}

class _UserRegisterCompletionScreenState
    extends State<UserRegisterCompletionScreen> {
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
                'assets/images/register_completion_header.png',
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
                  color: Colors.amber.withOpacity(0.2),
                ),
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
                    colors:  [
                      Colors.white,
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.08),
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
                      'Membership Complete',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: textScaleFactor * 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'We will approve your membership. thanks for your paitence',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UserLoginScreen.routeName,
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Ok. Let Me Know',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
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
                        Navigator.of(context).pushNamed(SurveyScreen.routeName);
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        // decoration: BoxDecoration(
                        //     color: Colors.black,
                        //     border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'support  (+61) 555 26 47',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: textScaleFactor * 12.0,
                            ),
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
