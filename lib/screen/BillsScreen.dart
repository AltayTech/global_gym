import 'package:flutter/material.dart';
import 'package:global_gym/models/Bill.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/provider/dimention.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/billScreenItem.dart';
import 'package:global_gym/widget/items/progressWidget.dart';
import 'package:provider/provider.dart';

class BillsScreen extends StatelessWidget {
  static const routeName = '/BillsScreen';

  String token;

  Future getBills(BuildContext context) async {
    var futureData = await Provider.of<UserPlans>(context, listen: false).getBillList();
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
    const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
    const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12
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
                        child: FutureBuilder(
                        future: getBills(context),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting)
                            return ProgressWidget();
                          else  {
                            if (snapshot.hasData) {
                              final billsList = snapshot.data as List<Bill>;
                              return Container(
                                  child: billsList.length > 0
                                      ? ListView.builder(
                                          // controller: _scrollController,
                                          // scrollDirection: Axis.vertical,
                                          itemCount: billsList.length,
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (ctx, i) {
                                            return Container(
                                            padding: EdgeInsets.only(bottom: 6),
                                            width: deviceWidth,
                                            height: 135,
                                            child: BillScreenItem(
                                              bill: billsList[i],
                                            ),
                                          );
                                          },
                                        )
                                      : Center(
                                          child: Padding(
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
                                        ));
                            } else
                              return Center(child: Text("Server Side Error!"));
                          }
                        },
                      ),
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
            BoxShadow(
                offset: Offset(0.0, 3.0),
                blurRadius: 1.0,
                spreadRadius: -2.0,
                color: _kKeyUmbraOpacity),
            BoxShadow(
                offset: Offset(0.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                color: _kKeyPenumbraOpacity),
            BoxShadow(
                offset: Offset(0.0, 1.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                color: _kAmbientShadowOpacity),
          ],
        ),
        height: kBottomNavigationBarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Status",
                style: TextStyle(
                  color: AppTheme.grey,
                  fontSize: textScaleFactor * 16.0,
                ),
              ),
              FutureBuilder(
                future: getBills(context),
                builder: (BuildContext context,
                    AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return Text(
                      "Debtor 0\$",
                      style: TextStyle(
                          color: AppTheme.black,
                          fontSize: textScaleFactor * 16.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    );
                  else  {
                    if (snapshot.hasData) {
                      return Text(
                        "Debtor ${totalStatus(snapshot.data as List<Bill>)}\$",
                        style: TextStyle(
                            color: AppTheme.black,
                            fontSize: textScaleFactor * 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      );
                    } else
                      return Text(
                        "Debtor 0\$",
                        style: TextStyle(
                            color: AppTheme.black,
                            fontSize: textScaleFactor * 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double totalStatus(List<Bill> billsList) {
    double billsTotalStatus = 0;

    if (billsList != null)
      billsList.forEach((element) {

        billsTotalStatus += element.Price;
      });

    return billsTotalStatus;
  }
}
