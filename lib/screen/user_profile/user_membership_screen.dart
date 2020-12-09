import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/user_models/plan.dart';
import 'package:global_gym/models/user_models/user_in_send.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/user_register_completion_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:global_gym/widget/items/plan_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class UserMembershipScreen extends StatefulWidget {
  static const routeName = '/UserMembershipScreen';

  @override
  _UserMembershipScreenState createState() => _UserMembershipScreenState();
}

class _UserMembershipScreenState extends State<UserMembershipScreen> {
  final _formKey = GlobalKey<FormState>();

  final accountNumberController = TextEditingController();

  final accountNameController = TextEditingController();

  final bankNameController = TextEditingController();

  bool _isLoading = false;

  bool _isInit = true;

  bool checkAgreement = false;

  List<Plan> plans = [];

  String groupValue;

  String _snackBarMessage = '';

  Plan selectedPlan;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getPlans();

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    accountNumberController.dispose();

    accountNumberController.dispose();

    bankNameController.dispose();

    super.dispose();
  }

  Future<bool> getPlans() async {
    _isLoading = true;
    setState(() {});
    bool response =
        await Provider.of<UserInfo>(context, listen: false).getPlans();

    plans = Provider.of<UserInfo>(context, listen: false).plans;

    _isLoading = false;
    setState(() {});
    return response;
  }

  Future<String> sendPlan() async {
    UserInSend user = Provider.of<UserInfo>(context, listen: false).userInSend;

    String response = await Provider.of<UserInfo>(context, listen: false)
        .sendPlan(selectedPlan.Id, '123456', accountNumberController.text,
            accountNameController.text, bankNameController.text);

    return response;
  }

  Future<String> submit() async {
    _isLoading = true;

    setState(() {});

    String isSent = await sendPlan();

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

    groupValue = Provider.of<UserInfo>(context).groupValue;

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
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24, right: 24, bottom: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/membership_header_ic.png',
                            height: 90,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Text(
                              'Membership',
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
                              'Please choose your membership plan',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'CircularStd',
                                fontWeight: FontWeight.w500,
                                fontSize: textScaleFactor * 16.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 4),
                            child: ListView.builder(
                              itemCount: plans.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Provider.of<UserInfo>(context, listen: false)
                                      .groupValue = plans[index].Name;
                                  selectedPlan = plans[index];
                                  setState(() {});
                                },
                                child: PlanItem(
                                  plan: plans[index],
                                ),
                              ),
                              shrinkWrap: true,
                              primary: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 16),
                            child: Container(
                              width: deviceWidth,
                              child: InkWell(
                                onTap: () {},
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Please Read ',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'CircularStd',
                                      fontWeight: FontWeight.w500,
                                      fontSize: textScaleFactor * 14.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Description',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black87,
                                          fontFamily: 'CircularStd',
                                          fontWeight: FontWeight.w500,
                                          fontSize: textScaleFactor * 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: Text(
                                'BSB info',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'CircularStd',
                                  fontWeight: FontWeight.w700,
                                  fontSize: textScaleFactor * 14.0,
                                ),
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
                                    title: 'Account Number',
                                    controller: accountNumberController,
                                    keyboardType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Account Name',
                                    controller: accountNameController,
                                    keyboardType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Bank Name',
                                    controller: bankNameController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: AppTheme.white,
                            width: deviceWidth,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6, left: 0, right: 8, bottom: 0),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                      onChanged: (value) {
                                        checkAgreement =
                                            checkAgreement ? false : true;

                                        setState(() {});
                                      },
                                      value: checkAgreement,
                                      activeColor: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 0, right: 0, bottom: 0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'I Read And Accept ',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'CircularStd',
                                          fontWeight: FontWeight.w500,
                                          fontSize: textScaleFactor * 14.0,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.amber,
                                              fontFamily: 'CircularStd',
                                              fontWeight: FontWeight.w500,
                                              fontSize: textScaleFactor * 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  if (!checkAgreement) {
                                    _snackBarMessage = 'Please Check Agreement';

                                    showNotification(context, _snackBarMessage);
                                  } else if (selectedPlan == null) {
                                    _snackBarMessage = 'Please Select a Plan';

                                    showNotification(context, _snackBarMessage);
                                  } else {
                                    await submit().then((value) async {
                                      if (value == 'true') {
                                        print(value.toString());

                                        Navigator.of(context).pushNamed(
                                            UserRegisterCompletionScreen
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
                                    'Proceed',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
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
