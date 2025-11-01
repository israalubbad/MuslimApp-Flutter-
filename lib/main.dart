import 'package:flutter/material.dart';
import 'package:fquran_app/View/screen/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'القرآن الكريم',
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}
