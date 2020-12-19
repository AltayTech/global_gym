import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/classes/media_query_helper.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/screen/home_screen.dart';
import 'package:global_gym/screen/user_profile/user_forget_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class UserLoginScreen extends StatefulWidget {
  static const routeName = '/UserLoginScreen';

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isLoading = false;

  bool _isInit = true;

  String _snackBarMessage;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  Future<String> sendEmail() async {
    String response = await Provider.of<Auth>(context, listen: false)
        .userLogin(emailController.text, passwordController.text);

    return response;
  }

  Future<String> submit() async {
    _isLoading = true;
    setState(() {});
    // Provider.of<UserInfo>(context, listen: false).userInSend.password =
    //     passwordController.text;
    //
    // Provider.of<UserInfo>(context, listen: false).userInSend.userName =
    //     emailController.text;

    String isSent = await sendEmail();

    _isLoading = false;
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    double deviceHeight = getHeight(context);
    double bodyHeight = getBodyHeight(context);
    double deviceWidth = getWidth(context);
    double textScaleFactor = getTextScaleFactor(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Builder(
          builder: (context) => Container(
            color: AppTheme.white,
            height: bodyHeight,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: bodyHeight,
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 24, right: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/login_header_ic.png',
                            height: 80,
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 16),
                            child: Text(
                              'Login',
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
                                top: 0, bottom: 8, left: 40, right: 40),
                            child: Text(
                              'Enter the following information to log in to your account',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w400,
                                fontSize: textScaleFactor * 14.0,
                              ),
                            ),
                          ),
                          Container(
                            color: AppTheme.white,
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  InfoEditItem(
                                    title: 'Email',
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    validateMessage: 'Plaese Enter Email',
                                  ),
                                  InfoEditItem(
                                    title: 'Password',
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText : true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 16),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            UserForgetPasswordScreen.routeName);
                                      },
                                      child: Text(
                                        'Forget my password',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black54,
                                          fontFamily: 'CircularStd',
                                          fontWeight: FontWeight.w600,
                                          fontSize: textScaleFactor * 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 8, bottom: 16),
                                  //   child: Text.rich(
                                  //     TextSpan(
                                  //       text: 'Hello ',
                                  //       style: TextStyle(fontSize: 50),
                                  //       children: <TextSpan>[
                                  //         TextSpan(
                                  //             text: 'world',
                                  //             style: TextStyle(
                                  //               decoration: TextDecoration.underline,
                                  //             )),
                                  //         // can add more TextSpans here...
                                  //       ],
                                  //     ),
                                  //   )
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);

                                  if (!emailValid) {
                                    _snackBarMessage =
                                        'Please Enter Email Correctly!';
                                    showNotification(context, _snackBarMessage);
                                  } else {
                                    await submit().then((value) async {
                                      if (value == 'true') {
                                        print(value.toString());
                                        Navigator.of(context)
                                            .pushNamed(HomeScreen.routeName);
                                      } else {
                                        _snackBarMessage = value;
                                        showNotification(
                                            context, _snackBarMessage);
                                      }
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: 48,
                                width: 366,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                  child: Text(
                                    'Next',
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
                        ],
                      ),
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
                                  color: index.isEven
                                      ? AppTheme.spinerColor
                                      : AppTheme.spinerColor,
                                ),
                              );
                            },
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
