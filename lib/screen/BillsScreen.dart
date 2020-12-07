import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/billScreenItem.dart';
import 'package:global_gym/widget/items/snake_bar.dart';
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

  double  billsTotalStatus;

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
          _snackBarMessage = value;
          SnakeBar.show(context, message: _snackBarMessage);
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


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    billsList = Provider.of<UserPlans>(context).billList;

    const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
    const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
    const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12
    billsTotalStatus=0;
    totalStatus(billsList);
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
              top: Dimention.topSpace,
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
                  Expanded(
                    child: Padding(
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
                              : billsList.length > 0
                                  ? ListView.builder(
                                      // controller: _scrollController,
                                      // scrollDirection: Axis.vertical,
                                      itemCount: billsList.length,
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (ctx, i) => Container(
                                        padding: EdgeInsets.only(bottom: 6),
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
                                    )),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(offset: Offset(0.0, 3.0), blurRadius: 1.0, spreadRadius: -2.0, color: _kKeyUmbraOpacity),
            BoxShadow(offset: Offset(0.0, 2.0), blurRadius: 2.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
            BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 5.0, spreadRadius: 0.0, color: _kAmbientShadowOpacity),
          ],
        ),
        height: kBottomNavigationBarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Status", style: TextStyle(
                color: AppTheme.grey,
                fontSize: textScaleFactor * 16.0,
              ),  ),
              Text("Debtor $billsTotalStatus\$",
                style: TextStyle(
                    color: AppTheme.black,
                    fontSize: textScaleFactor * 16.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void totalStatus(List<Bill> billsList) {
    billsList.forEach((element) {
      billsTotalStatus += element.Price;
    });
  }
}
