import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/login_screen.dart';

class EssenceApp extends StatelessWidget {
  const EssenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Essence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
