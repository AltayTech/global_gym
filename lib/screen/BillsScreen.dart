import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/billScreenItem.dart';
import 'package:provider/provider.dart';

class BillsScreen extends StatefulWidget {
  static const routeName = '/BillsScreen';

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  List<Bill> billsList = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getBills().then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          billsList = Provider.of<UserPlans>(context, listen: false).billList;
        } else {
          print('dsfsdssssssssssssssssssss');

          _snackBarMessage = value;
          showNotification(context, _snackBarMessage);
        }
      });

      getFoodList();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<String> getBills() async {
    _isLoading = true;
    setState(() {});

    String isSent =
        await Provider.of<UserPlans>(context, listen: false).getBillList();

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<String> getFoodList() async {
    String isSent =
        await Provider.of<UserPlans>(context, listen: false).getFoodList();
    print(isSent.toString());

    print(Provider.of<UserPlans>(context, listen: false).foodGroupList[0].Name);

    return isSent;
  }

  Future<void> showNotification(BuildContext ctx, String message) async {
    Builder(
      builder: (context) {
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
        Scaffold.of(context).showSnackBar(addToCartSnackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    billsList = Provider.of<UserPlans>(context).billList;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/bills_screen_header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              width: deviceWidth,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.01),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Text(
                      'Bills',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                        width: double.infinity,
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
                            : Container(
                                height: deviceHeight * 0.67,
                                child: billsList.length > 0
                                    ? ListView.builder(
                                        // controller: _scrollController,
                                        // scrollDirection: Axis.vertical,
                                        itemCount: billsList.length,
                                        padding: EdgeInsets.all(0),
                                        itemBuilder: (ctx, i) => Container(
                                          width: deviceWidth,
                                          height: 135,
                                          child: BillScreenItem(
                                            bill: billsList[i],
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                'You Have No bill List',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'CircularStd',
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              )),
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
