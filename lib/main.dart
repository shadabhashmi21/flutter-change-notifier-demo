import 'package:change_notifier_demo/model/cart_model.dart';
import 'package:change_notifier_demo/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: const DashboardPage(),
      ),
    );
  }
}
