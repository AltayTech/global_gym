import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/user_models/user_in_send.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/screen/user_profile/user_membership_screen.dart';
import 'package:global_gym/widget/items/info_edit_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_theme.dart';

class UserRegisterInfoScreen extends StatefulWidget {
  static const routeName = '/UserRegisterInfoScreen';

  @override
  _UserRegisterInfoScreenState createState() => _UserRegisterInfoScreenState();
}

enum GenderSelection { male, female }

class _UserRegisterInfoScreenState extends State<UserRegisterInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final lastNameController = TextEditingController();

  final givenNameController = TextEditingController();

  final dateOfBirthController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final line1Controller = TextEditingController();

  final line2Controller = TextEditingController();

  final subrubController = TextEditingController();

  final postalCodeController = TextEditingController();

  final nameRelationController = TextEditingController();

  final relationController = TextEditingController();

  final phoneNumberRelationController = TextEditingController();

  GenderSelection _character = GenderSelection.male;

  bool _isLoading = false;

  bool _isInit = true;

  String _snackBarMessage = '';

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    lastNameController.dispose();

    givenNameController.dispose();

    dateOfBirthController.dispose();

    phoneNumberController.dispose();

    line1Controller.dispose();

    line2Controller.dispose();

    line2Controller.dispose();

    subrubController.dispose();

    postalCodeController.dispose();

    nameRelationController.dispose();

    relationController.dispose();

    phoneNumberRelationController.dispose();

    super.dispose();
  }

  Future<String> sendInfo() async {
    Provider.of<UserInfo>(context, listen: false).userInSend.hashId =
        Provider.of<Auth>(context, listen: false).hashId;
    print(Provider.of<Auth>(context, listen: false).hashId.toString());
    UserInSend user = Provider.of<UserInfo>(context, listen: false).userInSend;

    String response =
        await Provider.of<Auth>(context, listen: false).sendInfo(user);

    return response;
  }

  Future<void> updateInfo() async {
    Provider.of<UserInfo>(context, listen: false).userInSend.hashId =
        Provider.of<Auth>(context, listen: false).hashId;

    Provider.of<UserInfo>(context, listen: false).userInSend.lastName =
        lastNameController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.firstName =
        givenNameController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.brithDate =
        dateOfBirthController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.gender =
        _character == GenderSelection.male;

    Provider.of<UserInfo>(context, listen: false).userInSend.phoneNumber =
        phoneNumberController.text;

    Provider.of<UserInfo>(context, listen: false)
        .userInSend
        .contactEmergencyName = nameRelationController.text;

    Provider.of<UserInfo>(context, listen: false)
        .userInSend
        .contactEmergencyNumber = phoneNumberRelationController.text;

    Provider.of<UserInfo>(context, listen: false)
        .userInSend
        .contactEmergencyRelation = relationController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.addressLine1 =
        line1Controller.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.addressLine2 =
        line2Controller.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.subrub =
        subrubController.text;

    Provider.of<UserInfo>(context, listen: false).userInSend.postalCode =
        postalCodeController.text;
  }

  Future<String> submit() async {
    await updateInfo();
    _isLoading = true;

    setState(() {});

    String isSent = await sendInfo();

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
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/survey_ic.png',
                            height: 90,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 37, right: 37, bottom: 16),
                            child: Text(
                              'Sign Up',
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
                          Container(
                            color: AppTheme.white,
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  InfoEditItem(
                                    title: 'Last Name',
                                    controller: lastNameController,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Given Name',
                                    controller: givenNameController,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Date of Birth',
                                    controller: dateOfBirthController,
                                    keybordType: TextInputType.datetime,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: deviceWidth * 0.8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        child: Wrap(
                                          children: <Widget>[
                                            Text(
                                              'Choose your gender',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'CircularStd',
                                                fontSize:
                                                    textScaleFactor * 13.0,
                                              ),
                                            ),
                                            Container(
                                              width: deviceWidth,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: RadioListTile<
                                                        GenderSelection>(
                                                      title: const Text('Man'),
                                                      value:
                                                          GenderSelection.male,
                                                      groupValue: _character,
                                                      onChanged:
                                                          (GenderSelection
                                                              value) {
                                                        setState(() {
                                                          _character = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: RadioListTile<
                                                        GenderSelection>(
                                                      title:
                                                          const Text('Woman'),
                                                      value: GenderSelection
                                                          .female,
                                                      groupValue: _character,
                                                      onChanged:
                                                          (GenderSelection
                                                              value) {
                                                        setState(() {
                                                          _character = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InfoEditItem(
                                    title: 'Phone number',
                                    controller: phoneNumberController,
                                    keybordType: TextInputType.phone,
                                  ),
                                  InfoEditItem(
                                    title: 'Line 1',
                                    controller: line1Controller,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Line 2',
                                    controller: line2Controller,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Subrub',
                                    controller: subrubController,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Postal Code',
                                    controller: postalCodeController,
                                    keybordType: TextInputType.number,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 2, left: 4),
                                    child: Text(
                                      'Address',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'CircularStd',
                                        fontWeight: FontWeight.w400,
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                    ),
                                  ),
                                  InfoEditItem(
                                    title: 'Name',
                                    controller: nameRelationController,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Relation',
                                    controller: relationController,
                                    keybordType: TextInputType.text,
                                  ),
                                  InfoEditItem(
                                    title: 'Phone Number',
                                    controller: phoneNumberRelationController,
                                    keybordType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  await submit().then((value) async {
                                    if (value == 'true') {
                                      print(value.toString());
                                      Navigator.of(context).pushNamed(
                                          UserMembershipScreen.routeName);
                                    } else {
                                      _snackBarMessage = value;
                                      showNotification(
                                          context, _snackBarMessage);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                height: 48,
                                width: 366,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                  child: Text(
                                    'Sign Up',
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
