import 'package:flutter/material.dart';
import 'package:global_gym/models/survey_question.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/user_register_survey_complete_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_survey_wrong_screen.dart';
import 'package:provider/provider.dart';

class OrderMealSelfMade extends StatefulWidget {
  static const routeName = '/OrderMealSelfMade';

  @override
  _OrderMealSelfMadeState createState() => _OrderMealSelfMadeState();
}

class _OrderMealSelfMadeState extends State<OrderMealSelfMade> {
  int itemIndex = 0;

  bool isInit = true;

  List<SurveyQuestion> surveyQuestion = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> answerQuestion(bool answer) {
    if (itemIndex < 6) {
      Provider.of<UserInfo>(context, listen: false).surveyQuestionList[itemIndex].answer = answer;
      itemIndex++;
      setState(() {});
    } else if (itemIndex == 6) {
      Navigator.of(context).pushNamed(UserRegisterSurveyCompleteScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    surveyQuestion = Provider.of<UserInfo>(context).surveyQuestionList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            height: 4,
            child: ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 2,
                  width: 20,
                  color: index <= itemIndex ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
        ),
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
                    padding: const EdgeInsets.only(top: 16, left: 37, right: 37, bottom: 16),
                    child: Text(
                      'Adult Pre Exercise Screening Tools',
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
                    padding: const EdgeInsets.only(top: 16, left: 37, right: 37, bottom: 16),
                    child: Container(
                      color: Color(0xffdfdfdf),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
                              child: Text(
                                '${surveyQuestion[itemIndex].id}/7',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'CircularStd',
                                  fontWeight: FontWeight.w700,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                              child: Text(
                                surveyQuestion[itemIndex].content,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'CircularStd',
                                  fontWeight: FontWeight.w500,
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
                    padding: const EdgeInsets.only(top: 80, left: 37, right: 37),
                    child: InkWell(
                      onTap: () {
                        answerQuestion(false);
                      },
                      child: Container(
                        height: 48,
                        width: 340,
                        decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'No',
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
                        Navigator.of(context).pushNamed(UserRegisterSurveyWrongScreen.routeName);
                      },
                      child: Container(
                        height: 48,
                        width: 340,
                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            'Yes',
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
