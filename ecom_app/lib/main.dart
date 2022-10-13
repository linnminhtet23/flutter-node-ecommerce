import 'package:ecom_app/constants/activate_constant.dart';
import 'package:ecom_app/screens/home.dart';
import 'package:ecom_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            backgroundColor: activeColors.primary,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: activeColors.primary,
            ),
          ),
          home: 
          Consumer<Auth>(builder: (context, auth, child){
            if(!auth.isAuth){
            return const Login();
            }else{
              return const Home();
            }
          },)
          ),
    );
  }
}
