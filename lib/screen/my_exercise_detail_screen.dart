import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_gym/models/week_day_exercise.dart';
import 'package:global_gym/provider/app_theme.dart';
import 'package:global_gym/widget/items/exercise_item.dart';
import 'package:provider/provider.dart';

class MyExerciseDetailScreen extends StatefulWidget {
  static const routeName = '/MyExerciseDetailScreen';

  @override
  _MyExerciseDetailScreenState createState() => _MyExerciseDetailScreenState();
}

class _MyExerciseDetailScreenState extends State<MyExerciseDetailScreen> {
  bool _isInit = true;

  var _isLoading;

  String token;

  String _snackBarMessage = '';

  WeekDayExercises weekDayExercise;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final Map argument = ModalRoute.of(context).settings.arguments as Map;

      weekDayExercise = argument['exercise'];

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/my_exercise_detail_header_pic.png',
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
                      Colors.white.withOpacity(0.01),
                      Colors.white.withOpacity(0.01),
                      Colors.white.withOpacity(0.01),
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
              top: 250,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 0, right: 0),
                        child: Text(
                          '${weekDayExercise.WeekDayName} Exercise',
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
                        padding: const EdgeInsets.only(left: 00, right: 0),
                        child: Container(
                          width: double.infinity,
                          child: _isLoading
                              ? SpinKitFadingCircle(
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                  child: weekDayExercise
                                              .UserTraningProgramExercises
                                              .length >
                                          0
                                      ? ListView.builder(
                                          // controller: _scrollController,
                                          // scrollDirection: Axis.vertical,
                                          itemCount: weekDayExercise
                                              .UserTraningProgramExercises
                                              .length,
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (ctx, i) =>
                                              ChangeNotifierProvider.value(
                                            value: weekDayExercise
                                                .UserTraningProgramExercises[i],
                                            child: Container(
                                              width: deviceWidth,
                                              height: 100,
                                              child: ExerciseItem(
                                                exercise: weekDayExercise
                                                    .UserTraningProgramExercises[i],
                                              ),
                                            ),
                                          ),
                                        )

                                      // weekDayExercise
                                      //                 .UserTraningProgramExercises.length >
                                      //             0
                                      //         ?
                                      //
                                      //
                                      //
                                      // Container(
                                      //             width: double.infinity,
                                      //             child: GridView.builder(
                                      //               scrollDirection: Axis.vertical,
                                      //               itemCount: weekDayExercise
                                      //                   .UserTraningProgramExercises.length,
                                      //               shrinkWrap: true,
                                      //               itemBuilder: (ctx, i) =>
                                      //                   ChangeNotifierProvider.value(
                                      //                 value: weekDayExercise
                                      //                     .UserTraningProgramExercises[i],
                                      //                 child: InkWell(
                                      //                   onTap: () {
                                      //                     // wasteCartItems =
                                      //                     //     Provider.of<Wastes>(context, listen: false)
                                      //                     //         .wasteCartItems;
                                      //                     // wasteCartItemsId =
                                      //                     //     Provider.of<Wastes>(context, listen: false)
                                      //                     //         .wasteCartItemsId;
                                      //                     //
                                      //                     // if (wasteCartItemsId.contains(loadedWastes[i].id)) {
                                      //                     //   Provider.of<Wastes>(context, listen: false)
                                      //                     //       .removeWasteCart(loadedWastes[i].id);
                                      //                     // } else {
                                      //                     //   Provider.of<Wastes>(context, listen: false)
                                      //                     //       .addWasteCart(loadedWastes[i], 1);
                                      //                     // }
                                      //                     // wasteCartItemsId =
                                      //                     //     Provider.of<Wastes>(context, listen: false)
                                      //                     //         .wasteCartItemsId;
                                      //                     //
                                      //                     // setState(() {});
                                      //                   },
                                      //                   child: ExerciseItem(
                                      //                     exercise: weekDayExercise
                                      //                         .UserTraningProgramExercises[i],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               gridDelegate:
                                      //                   SliverGridDelegateWithFixedCrossAxisCount(
                                      //                 crossAxisCount: 2,
                                      //                 childAspectRatio: 1,
                                      //                 crossAxisSpacing: 10,
                                      //                 mainAxisSpacing: 10,
                                      //               ),
                                      //             ),
                                      //           )
                                      //
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  'You Have No exercise List',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              Text(
                                                'You have no exercise for today',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'CircularStd',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      textScaleFactor * 16.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


