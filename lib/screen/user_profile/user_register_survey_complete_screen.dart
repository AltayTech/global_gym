import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/screen/user_profile/user_register_info_screen.dart';

import '../../provider/app_theme.dart';

class UserRegisterSurveyCompleteScreen extends StatefulWidget {
  static const routeName = '/UserRegisterSurveyCompleteScreen';

  @override
  _UserRegisterSurveyCompleteScreenState createState() =>
      _UserRegisterSurveyCompleteScreenState();
}

class _UserRegisterSurveyCompleteScreenState
    extends State<UserRegisterSurveyCompleteScreen> {
  bool _isLoading;

  bool _isInit = true;

  var checkAgreement = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
      ),
      backgroundColor: AppTheme.white,

      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(37),
          child: Container(
            color: AppTheme.white,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    color: AppTheme.white,
                    height: deviceHeight * 0.9,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/survey_ic.png',
                          height: 90,
                          width: 90,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 37, right: 37, bottom: 16),
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
                        Container(
                          color: AppTheme.white,
                          width: deviceWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                child: Checkbox(
                                  onChanged: (value) {
                                    checkAgreement =
                                        checkAgreement ? false : true;

                                    setState(() {});
                                  },
                                  value: checkAgreement,
                                  activeColor: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 4, right: 0, bottom: 0),
                                  child: Text(
                                    'I read and understood the Policy Terms and Conditions and declare the provided answers are correct.',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    maxLines: 5,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'CircularStd',
                                      fontWeight: FontWeight.w500,
                                      fontSize: textScaleFactor * 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,bottom:109 ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(UserRegisterInfoScreen.routeName);
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Text(
                                  'Continue',
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
                        SizedBox(
                          height: deviceHeight * 0.02,
                        )
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: _isLoading
                //         ? SpinKitFadingCircle(
                //             itemBuilder: (BuildContext context, int index) {
                //               return DecoratedBox(
                //                 decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   color: index.isEven
                //                       ? AppTheme.spinerColor
                //                       : AppTheme.spinerColor,
                //                 ),
                //               );
                //             },
                //           )
                //         : Container(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
