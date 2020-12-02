import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_gym/provider/auth.dart';
import 'package:global_gym/provider/strings.dart';
import 'package:global_gym/provider/user_info.dart';
import 'package:global_gym/provider/user_plans.dart';
import 'package:global_gym/screen/BillsScreen.dart';
import 'package:global_gym/screen/QRCodeScreen.dart';
import 'package:global_gym/screen/appointment/my_appointment_screen.dart';
import 'package:global_gym/screen/measurment/MyMeasurementDetailScreen.dart';
import 'package:global_gym/screen/measurment/MyMeasurementScreen.dart';
import 'package:global_gym/screen/my_diet_Screen.dart';
import 'package:global_gym/screen/my_diet_detail_screen.dart';
import 'package:global_gym/screen/my_exercise_detail_screen.dart';
import 'package:global_gym/screen/my_exercise_screen.dart';
import 'package:global_gym/screen/order_history/OrderHistoryScreen.dart';
import 'package:global_gym/screen/order_meal/order_mail_pre_made.dart';
import 'package:global_gym/screen/splash_Screen.dart';
import 'package:global_gym/screen/survey_screen.dart';
import 'package:global_gym/screen/user_profile/change_pass_verification_code_screen.dart';
import 'package:global_gym/screen/user_profile/forget_verification_code_screen.dart';
import 'package:global_gym/screen/user_profile/user_change_password_screen.dart';
import 'package:global_gym/screen/user_profile/user_forget_screen.dart';
import 'package:global_gym/screen/user_profile/user_login_screen.dart';
import 'package:global_gym/screen/user_profile/user_membership_screen.dart';
import 'package:global_gym/screen/user_profile/user_new_password_screen.dart';
import 'package:global_gym/screen/user_profile/user_profile_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_completion_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_email_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_info_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_survey_wrong_screen.dart';
import 'package:global_gym/screen/user_profile/user_register_verification_code_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'provider/app_theme.dart';
import 'screen/home_screen.dart';
import 'screen/user_profile/user_register_survey_complete_screen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserInfo(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserPlans(),
          ),
        ],
        child: MaterialApp(
          title: Strings.appTitle,
          theme: ThemeData(
              primaryColor: Colors.orange,
              backgroundColor: AppTheme.bg,
              textTheme: AppTheme.textTheme,
              appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
          home: Directionality(
            child: SplashScreen(),
            textDirection: TextDirection.rtl, // setting rtl
          ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SurveyScreen.routeName: (ctx) => SurveyScreen(),
            UserRegisterInfoScreen.routeName: (ctx) => UserRegisterInfoScreen(),
            UserMembershipScreen.routeName: (ctx) => UserMembershipScreen(),
            UserRegisterSurveyCompleteScreen.routeName: (ctx) => UserRegisterSurveyCompleteScreen(),
            UserRegisterVerificationCodeScreen.routeName: (ctx) => UserRegisterVerificationCodeScreen(),
            UserRegisterEmailScreen.routeName: (ctx) => UserRegisterEmailScreen(),
            UserRegisterCompletionScreen.routeName: (ctx) => UserRegisterCompletionScreen(),
            UserRegisterSurveyWrongScreen.routeName: (ctx) => UserRegisterSurveyWrongScreen(),
            UserLoginScreen.routeName: (ctx) => UserLoginScreen(),
            UserForgetPasswordScreen.routeName: (ctx) => UserForgetPasswordScreen(),
            UserNewPasswordScreen.routeName: (ctx) => UserNewPasswordScreen(),
            ForgetVerificationCodeScreen.routeName: (ctx) => ForgetVerificationCodeScreen(),
            MyDietScreen.routeName: (ctx) => MyDietScreen(),
            MyDietDetailScreen.routeName: (ctx) => MyDietDetailScreen(),
            MyExerciseScreen.routeName: (ctx) => MyExerciseScreen(),
            MyExerciseDetailScreen.routeName: (ctx) => MyExerciseDetailScreen(),
            OrderMealPreMade.routeName: (ctx) => OrderMealPreMade(),
            MyMeasurementScreen.routeName: (ctx) => MyMeasurementScreen(),
            MyMeasurementDetailScreen.routeName: (ctx) => MyMeasurementDetailScreen(),
            MyAppointmentScreen.routeName: (ctx) => MyAppointmentScreen(),
            OrderHistoryScreen.routeName: (ctx) => OrderHistoryScreen(),
            BillsScreen.routeName: (ctx) => BillsScreen(),
            QRCodeScreen.routeName: (ctx) => QRCodeScreen(),
            UserChangePasswordScreen.routeName: (ctx) => UserChangePasswordScreen(),
            ChangePassVerificationCodeScreen.routeName: (ctx) => ChangePassVerificationCodeScreen(),
            UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          },
        ));
  }
}
