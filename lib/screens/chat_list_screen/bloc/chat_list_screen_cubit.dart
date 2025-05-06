import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ealphabits_practical/screens/chat_list_screen/model/chat_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login_screen/view/login_screen.dart';


class ChatListScreenCubit extends Cubit<List<ChatUserModel>> {
  ChatListScreenCubit() : super([]);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loadFirebaseUsers() async {
    try {
      final currentUserId = auth.currentUser?.uid;
      if (currentUserId == null) {
        emit([]);
        return;
      }
      final snapshot = await firestore.collection('users').get();
      for (var doc in snapshot.docs) {
        print("Raw Firestore doc: ${doc.data()}");
      }
      final users = snapshot.docs
          .map((doc) => ChatUserModel.fromJson(doc.data()))
          .where((user) => user.userId != currentUserId)
          .toList();
      emit(users);

    } catch (e) {
      print('Error loading users: $e');
    }
  }

  // Sign out the current user
  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    debugPrint('Sign Out');

    // Navigate to LoginScreen after signing out
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }
}


