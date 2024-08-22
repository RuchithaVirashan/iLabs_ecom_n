import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'logic/bloc/product_list/bloc/product_list_bloc.dart';
import 'presentation/routes/app_route.dart';
import 'presentation/screens/main_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRoute appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const ui.Size(414, 896),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ProductListBloc()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ecomnew',
              theme: AppTheme.lightTheme,
              onGenerateRoute: appRoute.onGenerateRoute,
            ),
          );
        });
  }
}
