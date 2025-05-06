import 'package:ealphabits_practical/screens/chat_list_screen/view/chat_list_screen.dart';
import 'package:ealphabits_practical/screens/login_screen/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData){
        return ChatListScreen();
      } else {
        return LoginScreen();
      }
    },);
  }
}
