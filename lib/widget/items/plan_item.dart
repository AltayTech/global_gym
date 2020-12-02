import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/models/user_models/plan.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:provider/provider.dart';

class PlanItem extends StatefulWidget {
  const PlanItem({
    Key key,
    @required this.plan,
  }) : super(key: key);

  final Plan plan;

  @override
  _PlanItemState createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  String groupValue;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    groupValue = Provider.of<UserInfo>(context).groupValue;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
            color: groupValue == widget.plan.Name
                ? Color.fromARGB(255, 183, 5, 12).withOpacity(0.12)
                : Colors.white,
            border: Border.all(
              color:
                  groupValue == widget.plan.Name ? Colors.amber : Colors.grey,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 20,
                child: Center(
                  child: Radio(
                    value: widget.plan.Name,
                    groupValue: groupValue,
                    onChanged: (String value) {
                      Provider.of<UserInfo>(context, listen: false).groupValue =
                          value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '6 Month',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CircularStd',
                            fontWeight: FontWeight.w800,
                            fontSize: textScaleFactor * 18.0,
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.plan.Price.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CircularStd',
                            fontWeight: FontWeight.w800,
                            fontSize: textScaleFactor * 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        widget.plan.Name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'CircularStd',
                          fontSize: textScaleFactor * 16.0,
                        ),
                      ),
                    ),
                    Text(
                      widget.plan.PriceDescription,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w400,
                        fontSize: textScaleFactor * 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
