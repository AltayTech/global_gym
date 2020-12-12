import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/urls.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/forget_verification_code_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeScreen extends StatelessWidget {
  static const routeName = '/QRCodeScreen';

  bool _isLoading = false;

  bool _isInit = true;

  String _snackBarMessage;

  String image;

  SharedPreferences prefs;

  Future<NetworkImage> _getQRCode(BuildContext context) async {
    NetworkImage image = await Provider.of<UserInfo>(context, listen: false).getQRCode();
    return image;
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
      body: Container(
        color: AppTheme.white,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 24, right: 24),
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
              Expanded(
                child: Container(
                  child: Center(
                    child: FutureBuilder(
                      future: _getQRCode(context),
                      builder: (BuildContext context, AsyncSnapshot<NetworkImage> snapshot){
                        if(snapshot.connectionState==ConnectionState.done)
                        {
                          if(snapshot.hasData){
                            return Container(
                                color: AppTheme.white,
                                child: Image(image: snapshot.data)
                            );
                          } else if(snapshot.hasError)
                            return Center(child: Text("Server Error!"));
                          else return Container();
                        }
                        else if(snapshot.connectionState==ConnectionState.waiting)
                          return ProgressWidget();
                        else return Container();
                      },
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
    );
  }
}
