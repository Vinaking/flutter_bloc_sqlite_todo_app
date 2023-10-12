import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite_todo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BlocSqlDemo())));
    super.initState();
  }
}
