import 'package:flutter/material.dart';
import 'core/router.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Desktop MVP',
      routerConfig: router,
    );
  }
}
