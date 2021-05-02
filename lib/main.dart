import 'package:flutter/material.dart';
import 'package:tiki_challenge/router/customer_router.dart';
import 'package:tiki_challenge/router/router_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CustomerRouter.allRoutes,
      initialRoute: router_api,
    );
  }
}
