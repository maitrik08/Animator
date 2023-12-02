import 'package:animator/HomeScreen.dart';
import 'package:animator/Planetmodel.dart';
import 'package:animator/SplashScreen.dart';
import 'package:animator/Themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('appTheme') ?? false;
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider(isDark: isDark),),
      ChangeNotifierProvider(create: (context) => FavoritePlanetss()),
      ChangeNotifierProvider(
        create: (context) => PlanetModel(),
        child: MyApp(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: (Provider.of<ThemeProvider>(context).isDark) ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
