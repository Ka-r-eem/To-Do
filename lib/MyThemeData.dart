
import 'package:flutter/material.dart';

class MyThemeData {
  static const Color lightPrimary =  Colors.blue;
  static const Color darkPrimary =  Colors.blue;
  static const Color lightSecondary =  Colors.white;
  static const Color darkSecondary =  Color(0xFF060E1E);

  static ThemeData lightTheme  = ThemeData(

    floatingActionButtonTheme: const
    FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
    ),

        textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 20 ,
        fontWeight: FontWeight.w400,
        color: Colors.black
      ),
          headlineSmall: TextStyle(
        fontSize: 25 ,
            fontWeight: FontWeight.w600,
            color: Colors.black
    )
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white ,

    ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(

        backgroundColor: lightPrimary,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,

      ),

      primaryColor: lightPrimary,
      colorScheme: ColorScheme.fromSeed(
          seedColor: lightPrimary,
          primary: lightPrimary,
          secondary: lightSecondary,
          onPrimary: Colors.black87,


      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData( color: Colors.white),
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          shadowColor: Colors.transparent));


   static ThemeData darkTheme = ThemeData(
       primaryColor: darkPrimary,
       colorScheme: ColorScheme.fromSeed(

           seedColor: darkPrimary,
           primary: lightPrimary,
           secondary: darkSecondary,
           onPrimary: Colors.white,),

       floatingActionButtonTheme: const FloatingActionButtonThemeData(
         backgroundColor: Colors.blue,
       ),
     bottomSheetTheme:  BottomSheetThemeData(
       backgroundColor: darkSecondary ,
     ),
       textTheme: const TextTheme(
           bodySmall: TextStyle(
               fontSize: 20 ,
               fontWeight: FontWeight.w400,
               color: Colors.white
           ),
           headlineSmall: TextStyle(
               fontSize: 25 ,
               fontWeight: FontWeight.w600,
               color: Colors.white
           )
       ),

       bottomNavigationBarTheme: const BottomNavigationBarThemeData(

         backgroundColor: Colors.transparent,
         selectedItemColor: Colors.blue,
         unselectedItemColor: Colors.grey,

       ),
      bottomAppBarTheme:BottomAppBarTheme(
       color: Color(0xFF141922),
      ),
      scaffoldBackgroundColor: Colors.transparent,
       appBarTheme: const AppBarTheme(
           iconTheme: IconThemeData( color: Colors.white),
           backgroundColor: Colors.transparent,
           centerTitle: true,
           titleTextStyle: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
           shadowColor: Colors.transparent));
}