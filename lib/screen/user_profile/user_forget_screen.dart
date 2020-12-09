import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/forget_verification_code_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class UserForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/UserForgetPasswordScreen';

  @override
  _UserForgetPasswordScreenState createState() =>
      _UserForgetPasswordScreenState();
}

class _UserForgetPasswordScreenState extends State<UserForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  bool _isLoading = false;

  bool _isInit = true;

  String _snackBarMessage;

  String username;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      username =
          Provider.of<UserInfo>(context, listen: false).userInSend.userName;
      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  Future<String> sendForgetCode() async {
    String response = await Provider.of<Auth>(context, listen: false)
        .sendForgetCode(emailController.text);

    return response;
  }

  Future<String> submit() async {
    _isLoading = true;
    setState(() {});

    String isSent = await sendForgetCode();

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
                    color: Colors.transparent,
                    height: deviceHeight * 0.9,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 24, right: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/forget_pass_header_ic.png',
                            height: 90,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              'Forget Password',
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
                            padding: const EdgeInsets.only(top: 0, bottom: 16),
                            child: Text(
                              'Enter your email to receive the verification code',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                          Container(
                            color: AppTheme.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: Form(
                                key: _formKey,
                                child: InfoEditItem(
                                  title: 'Email',
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  validateMessage: 'Please Enter Email',
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 36),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  if (emailController.text == '' ||
                                      emailController.text == null) {
                                    // _snackBarMessage = 'Please Enter Code';
                                    // showNotification(context, _snackBarMessage);
                                  } else {
                                    await submit().then((value) async {
                                      if (value == 'true') {
                                        print(value.toString());
                                        Navigator.of(context).pushNamed(
                                            ForgetVerificationCodeScreen
                                                .routeName);
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
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                  child: Text(
                                    'Send',
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
