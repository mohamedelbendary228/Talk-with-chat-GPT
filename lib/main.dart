import 'package:flutter/material.dart';
import 'package:talk_with_gpt/utils/colors.dart';
import 'package:talk_with_gpt/screens/home_page.dart';
import 'package:talk_with_gpt/utils/dio_client.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk with GPT',
      locale: const Locale("en"),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}
