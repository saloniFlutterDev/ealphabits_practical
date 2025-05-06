import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/local_data/shared_pref_utils.dart';
import '../model/local_user_model.dart';
import '../model/user_login_request_model.dart';

class LoginCubit extends Cubit<UserLoginRequestState> {
  LoginCubit() : super(UserLoginRequestInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> userLogin(UserLoginRequestModel userLoginRequestModel) async {
    emit(UserLoginRequestLoading());
    EasyLoading.show();
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: userLoginRequestModel.email ?? "",
        password: userLoginRequestModel.password ?? "",
      );

      final user = userCredential.user;

      if (user != null) {
        final doc = await usersCollection.doc(user.uid).get();

        final userModel = LocalUserModel(
          id: user.uid,
          email: user.email ?? '',
          firstName: user.displayName,
        );

        await SharedPreferenceUtils.setUser(userModel);
        await SharedPreferenceUtils.setToken(await user.getIdToken() ?? '');
        await SharedPreferenceUtils.setRemember(true);

        emit(UserLoginRequestSuccess(userModel));
      } else {
        emit(UserLoginRequestError("Login failed: No user found."));
      }
    } on FirebaseAuthException catch (e) {
      emit(UserLoginRequestError(e.message ?? "Login failed"));
    } catch (e) {
      emit(UserLoginRequestError("Unexpected error: $e"));
    } finally {
      EasyLoading.dismiss();
    }
  }
}


abstract class UserLoginRequestState {}

class UserLoginRequestInitial extends UserLoginRequestState {}

class UserLoginRequestLoading extends UserLoginRequestState {}

class UserLoginRequestSuccess extends UserLoginRequestState {
  final dynamic data;

  UserLoginRequestSuccess(this.data);
}

class UserLoginRequestError extends UserLoginRequestState {
  final String message;

  UserLoginRequestError(this.message);
}
