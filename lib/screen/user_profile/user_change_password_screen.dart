import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/user_login_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class UserChangePasswordScreen extends StatefulWidget {
  static const routeName = '/UserChangePasswordScreen';

  @override
  _UserChangePasswordScreenState createState() => _UserChangePasswordScreenState();
}

class _UserChangePasswordScreenState extends State<UserChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();

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
    passwordController.dispose();

    rePasswordController.dispose();

    super.dispose();
  }

  Future<String> sendPassword() async {
    String response = await Provider.of<Auth>(context, listen: false)
        .sendNewPassword(passwordController.text, rePasswordController.text);

    return response;
  }

  Future<String> submit() async {
    _isLoading = true;
    setState(() {});
    Provider.of<UserInfo>(context, listen: false).userInSend.password = passwordController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.rePassword = rePasswordController.text;

    String isSent = await sendPassword();

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<void> showNotification(String message) async {
    SnackBar addToCartSnackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
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
    Scaffold.of(context).showSnackBar(addToCartSnackBar);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Builder(
          builder: (context) => Container(
            color: AppTheme.white,
            height: deviceHeight * 0.9,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: deviceHeight * 0.9,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/new_password_header_ic.png',
                            height: 90,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Text(
                              'Change Password',
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
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  InfoEditItem(
                                    title: 'New Password',
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                  InfoEditItem(
                                    title: 'Repeat Password',
                                    controller: rePasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 32),
                            child: InkWell(
                              onTap: () async {
                                FocusScope.of(context).requestFocus(new FocusNode());

                                if (_formKey.currentState.validate()) {
                                  if (passwordController.text != rePasswordController.text) {
                                    _snackBarMessage = 'Password does not match!';
                                    showNotification(_snackBarMessage);
                                  } else {
                                    await submit().then((value) async {
                                      if (value == 'true') {
                                        print(value.toString());
                                        Navigator.of(context).pushNamed(UserLoginScreen.routeName);
                                      } else {
                                        _snackBarMessage = value;
                                        showNotification(_snackBarMessage);
                                      }
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: 48,
                                width: 366,
                                decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.black)),
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
                          SizedBox(
                            height: deviceHeight * 0.02,
                          )
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
          ),
        ),
      ),
    );
  }
}
