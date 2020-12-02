import 'package:flutter/material.dart';
import 'package:global_gym/models/survey_question.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/user_register_survey_complete_screen.dart';
import 'package:provider/provider.dart';

class UserRegisterSurveyWrongScreen extends StatefulWidget {
  static const routeName = '/UserRegisterSurveyWrongScreen';

  @override
  _UserRegisterSurveyWrongScreenState createState() =>
      _UserRegisterSurveyWrongScreenState();
}

class _UserRegisterSurveyWrongScreenState
    extends State<UserRegisterSurveyWrongScreen> {

  bool isInit = true;

  List<SurveyQuestion> surveyQuestion = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,

      ),
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/survey_ic.png',
                    height: 90,
                    width: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 37, right: 37, bottom: 16),
                    child: Text(
                      'Reject',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w800,
                        fontSize: textScaleFactor * 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 37, right: 37, bottom: 16),
                    child: Container(
                      color: Color(0xffdfdfdf),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8, bottom: 8),
                              child: Text(
                                'According to the Rules And Regulations Of Your Organization, You Are Not Allowed To Enter And Use The Application. If Necessary, You Can ContactSupport.',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 5,
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 37, right: 37),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        height: 48,
                        width: 340,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Exit',
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
                    padding: const EdgeInsets.only(top: 8, left: 37, right: 37),
                    child: InkWell(
                      onTap: () {
                        // answerQuestion(true);
                      },
                      child: Container(
                        height: 48,
                        width: 340,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Call Us: +61 555 36 69',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
