import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:untitled4/modules/Expert/Auth/login_screen.dart';

void main(covariant)
{
 runApp(MyApp());
 MyApp app = MyApp();
 Widget a = MyApp();
}
class MyApp extends StatelessWidget
{
 @override
 Widget build(BuildContext context)
 {
  return MaterialApp(
   theme: ThemeData(
    appBarTheme: AppBarTheme(
     iconTheme: IconThemeData(
      color: Colors.black,
     ),
     backwardsCompatibility: false,
     systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
     ),
     backgroundColor: Colors.white,
     elevation: 0.0,
     titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
     )
    )
   ),
   home :LoginScreen(),
   debugShowCheckedModeBanner: false,
  );
 }
}