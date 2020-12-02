import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:provider/provider.dart';

class DashBoardItem extends StatefulWidget {
  const DashBoardItem({
    Key key,
    @required this.title,
    @required this.header,
    @required this.name,
    @required this.icon,
    @required this.image,
    @required this.fcn,
  }) : super(key: key);

  final String title;
  final String header;
  final String name;
  final Icon icon;
  final Image image;
  final Function fcn;

  @override
  _DashBoardItemState createState() => _DashBoardItemState();
}

class _DashBoardItemState extends State<DashBoardItem> {
  String groupValue;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;
    groupValue = Provider
        .of<UserInfo>(context)
        .groupValue;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: textScaleFactor * 16.0,
                  ),
                ),
                Text(
                  widget.header,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                     color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: textScaleFactor * 16.0,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: widget.fcn,
            child: Container(
              width: double.infinity,
              height: 160,
              child: Stack(
                children: [
                  Positioned.fill(child: widget.image),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Row(
                      children: [
                        widget.icon,
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: textScaleFactor * 16.0,
                                ),
                              ),
                              Text(
                                'View Details',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CircularStd',
                                  fontWeight: FontWeight.w300,
                                  fontSize: textScaleFactor * 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
