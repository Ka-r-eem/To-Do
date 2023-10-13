import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/providers/settingsProvider/SettingsProvider.dart';
import 'package:todo_app/ui/Login/loginScreen.dart';
import 'package:todo_app/ui/Register/registerScreen.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';
import 'package:todo_app/ui/splash/splash.dart';

import 'MyThemeData.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => SettingsProvider())
  ],

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(


      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(settingsProvider.currentLocale),
      title: 'Flutter Demo',
      routes: {
        registerScreen.routeName : (_)=> registerScreen(),
        login.routeName :(_)=> login(),
        HomeScreen.routeName :(_)=> HomeScreen(),
        splash.routeName : (_)=> splash(),
      },
      initialRoute: splash.routeName ,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: settingsProvider.currentTheme,



);

  }
}




