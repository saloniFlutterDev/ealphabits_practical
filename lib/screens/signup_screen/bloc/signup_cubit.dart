import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/local_data/shared_pref_utils.dart';
import '../../login_screen/model/local_user_model.dart';
import '../model/user_signup_request_model.dart';

class SignupCubit extends Cubit<SignupRequestState> {
  SignupCubit() : super(SignupRequestInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> signUpUser(UserSignUpRequestModel userSignUpRequestModel) async {
    emit(SignupRequestLoading());
    EasyLoading.show();

    try {
      final methods = await firebaseAuth.fetchSignInMethodsForEmail(userSignUpRequestModel.email ??"");
      if (methods.isNotEmpty) {
        EasyLoading.dismiss();
        emit(SignupRequestError("User already exists. Please login instead."));
        return;
      }

      // Create new user
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: userSignUpRequestModel.email ?? "",
        password: userSignUpRequestModel.password ??"",
      );

      final user = userCredential.user;
      if (user != null) {
        final userId = user.uid;

        await firestore.collection('users').doc(userId).set({
          'id': userId,
          'name':userSignUpRequestModel.name ?? '',
          'email': userSignUpRequestModel.email,
          'profileImgUrl': 'https://i.pravatar.cc/150?img=9',
          'chatId': userId,
          'lastMessage': '',
          'sendAt': FieldValue.serverTimestamp(),
        });

        final token = await user.getIdToken();
        final userModel = LocalUserModel(
          id: user.uid,
          email: user.email,
          firstName: userSignUpRequestModel.name ?? '',
        );

        await SharedPreferenceUtils.setToken(token ?? "");
        await SharedPreferenceUtils.setUser(userModel);
        await SharedPreferenceUtils.setRemember(true);

        emit(SignupRequestSuccess(user));
      } else {
        emit(SignupRequestError("User signup failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(SignupRequestError(e.message ?? "Signup failed"));
    } catch (e) {
      emit(SignupRequestError("Unexpected error: $e"));
    } finally {
      EasyLoading.dismiss();
    }
  }
}


abstract class SignupRequestState {}

class SignupRequestInitial extends SignupRequestState {}

class SignupRequestLoading extends SignupRequestState {}

class SignupRequestSuccess extends SignupRequestState {
  final dynamic data;

  SignupRequestSuccess(this.data);
}

class SignupRequestError extends SignupRequestState {
  final String message;

  SignupRequestError(this.message);
}
