import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/forget_verification_code_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:provider/provider.dart';

class QRCodeScreen extends StatefulWidget {
  static const routeName = '/QRCodeScreen';

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  bool _isLoading = false;

  bool _isInit = true;

  String _snackBarMessage;

  File image;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getQRCode().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          image = Provider.of<UserInfo>(context, listen: false).QrCode;
        } else {
          print('dsfsdssssssssssssssssssss');

          _snackBarMessage = value;
          showNotification(context, _snackBarMessage);
        }
      });

      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<String> getQRCode() async {
    _isLoading = true;
    setState(() {});

    String isSent =
        await Provider.of<UserInfo>(context, listen: false).getQRCode();

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
                            'assets/images/logo.png',
                            height: 90,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              'Membership Access Key',
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
                              'Please place the QR code in front of the device to scan it',
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
                          Align(
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
                                :  Container(
                              color: AppTheme.white,
                              child: Image.file(image),
                            ),
                          )
                         ,
                          Spacer(),
                          SizedBox(
                            height: deviceHeight * 0.02,
                          )
                        ],
                      ),
                    ),
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
