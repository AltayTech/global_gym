import 'package:flutter/material.dart';
import 'package:global_gym/models/Reserve.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/widget/items/appoinment_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyAppointmentScreen extends StatefulWidget {
  static const routeName = '/MyAppointmentScreen';

  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  List<Reserve> reserveList = [];

  CalendarController _calendarController;

  Map<DateTime, List> events;

  List _selectedEvents = [];
  List _selectedEventsList = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await getReserveList(DateTime.now()).then((value) async {
        if (value == 'true') {
          print(value.toString());
          // Navigator.of(context).pushNamed(
          //     UserNewPasswordScreen.routeName);

          reserveList =
              Provider.of<UserPlans>(context, listen: false).reserveList;
          events = await getEvents();
        } else {
          print('dsfsdssssssssssssssssssss');

          _snackBarMessage = value;
          showNotification(context, _snackBarMessage);
        }
      });

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<String> getReserveList(DateTime dateTime) async {
    _isLoading = true;
    setState(() {});

    String date = '${dateTime.year}/${dateTime.month}/${dateTime.day}';

    String isSent = await Provider.of<UserPlans>(context, listen: false)
        .getReserveList(date);

    _isLoading = false;
    setState(() {});
    return isSent;
  }

  Future<Map<DateTime, List>> getEvents() async {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    Map<DateTime, List> mapFetch = {};
    for (int i = 0; i < reserveList.length; i++) {
      var createTime = formatter.parse(reserveList[i].Date);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [reserveList[i].UserFullName];
      } else {
        print(reserveList[i].UserFullName);
        mapFetch[createTime] = List.from(original)
          ..addAll([reserveList[i].UserFullName]);
      }
    }

    return mapFetch;
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
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    reserveList = Provider.of<UserPlans>(context).reserveList;

    Widget _buildEventsMarker(DateTime date, List events) {
      return Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.black45,
            fontSize: 12.0,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text('My Appointment'),
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
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TableCalendar(
                    calendarController: _calendarController,
                    events: events,
                    builders: CalendarBuilders(
                      // selectedDayBuilder: (context, date, _) {
                      //   return Container(
                      //     margin: const EdgeInsets.all(4.0),
                      //     padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      //     color: Colors.deepOrange[300],
                      //     width: 100,
                      //     height: 100,
                      //     child: Text(
                      //       '${date.day}',
                      //       style: TextStyle().copyWith(fontSize: 16.0),
                      //     ),
                      //   );
                      // },
                      // todayDayBuilder: (context, date, _) {
                      //   return Container(
                      //     margin: const EdgeInsets.all(4.0),
                      //     padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      //     color: Colors.amber[400],
                      //     width: 100,
                      //     height: 100,
                      //     child: Text(
                      //       '${date.day}',
                      //       style: TextStyle().copyWith(fontSize: 16.0),
                      //     ),
                      //   );
                      // },
                      markersBuilder: (context, date, events, holidays) {
                        final children = <Widget>[];

                        if (events.isNotEmpty) {
                          children.add(
                            Positioned(
                              right: 1,
                              bottom: 1,
                              child: _buildEventsMarker(date, events),
                            ),
                          );
                        }

                        return children;
                      },
                    ),
                    onDaySelected: (day, events, holidays) {
                      setState(() {
                        _selectedEvents = events;

                      });
                    },
                    calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.amber,
                      selectedColor: Colors.amberAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      'Training List',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        // controller: _scrollController,
                        // scrollDirection: Axis.vertical,
                        itemCount: reserveList.length,
                        padding: EdgeInsets.all(0),

                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                          value: reserveList[i],
                          child: Container(
                            width: deviceWidth,
                            child: AppointmentItem(
                              reserve: reserveList[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
