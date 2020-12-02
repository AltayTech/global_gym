import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/provider/app_theme.dart';

class InfoEditItem extends StatelessWidget {
  const InfoEditItem({
    Key key,
    @required this.title,
    @required this.controller,
    @required this.keybordType,
    this.validateMessage = 'Please Enter Correct value',
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType keybordType;
  final String validateMessage;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
//      width: deviceWidth * 0.8,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4),
        child: Container(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
                child: Text(
                  '$title',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'CircularStd',
                    fontWeight: FontWeight.w600,
                    fontSize: textScaleFactor * 14.0,
                  ),
                ),
              ),
              Container(
                color: Colors.blue.withOpacity(0.05),
                child: TextFormField(
                  keyboardType: keybordType,
                  onEditingComplete: () {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return validateMessage;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right: 8, left: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(width: 0,color: Colors.white),

                    ),
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'CircularStd',
                      fontSize: textScaleFactor * 10.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
