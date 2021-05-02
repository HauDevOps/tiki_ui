import 'package:flutter/material.dart';
import 'package:tiki_challenge/bloc/base_bloc.dart';
import 'package:tiki_challenge/page/home/home_bloc.dart';
import 'package:tiki_challenge/page/home/home_page.dart';
import 'package:tiki_challenge/router/router_name.dart';

class CustomerRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case router_api:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              child: HomePage(),
              bloc: HomeBloc(),
            ));
        return MaterialPageRoute(builder: (_) => null);
    }
  }
}