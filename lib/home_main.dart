import 'package:ealphabits_practical/screens/chat_list_screen/view/chat_list_screen.dart';
import 'package:ealphabits_practical/screens/login_screen/bloc/auth_cubit.dart';
import 'package:ealphabits_practical/screens/login_screen/view/auth_check.dart';
import 'package:ealphabits_practical/screens/login_screen/view/login_screen.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        title: BaseStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: const {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        builder: EasyLoading.init(),
        home: AuthCheck(),
      ),
    );
  }
}
