import 'package:ealphabits_practical/screens/chat_list_screen/view/chat_list_screen.dart';
import 'package:ealphabits_practical/screens/signup_screen/view/signup_screen.dart';
import 'package:ealphabits_practical/utils/base_button.dart';
import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:ealphabits_practical/utils/base_common_text_field.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:ealphabits_practical/utils/base_validation.dart';
import 'package:ealphabits_practical/utils/base_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../utils/base_strings.dart';
import '../bloc/auth_cubit.dart';
import '../model/user_login_request_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  final LoginCubit loginCubit = LoginCubit();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emailFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, UserLoginRequestState>(
      listener: (context, state) {
        if (state is UserLoginRequestSuccess) {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const ChatListScreen(),), (route) => false);
        } else if (state is UserLoginRequestError) {
          EasyLoading.dismiss();
          BaseWidgets.toastMessage(title: state.message);
        }
      },
      builder: (context, builderState) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: BaseColorConstants.background,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Center(child: Text(BaseStrings.signIn, style: BaseTextStyle.chatListScreenTitle)),
                    SizedBox(height: 60),
                    Text(BaseStrings.email, style: BaseTextStyle.titleTextStyle, textAlign: TextAlign.start),
                    SizedBox(height: 10),
                    BaseCommonTextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      hint: BaseStrings.enterEmailAddress,
                      textCapitalization: TextCapitalization.none,
                      focusNode: emailFocus,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return BaseStrings.pleaseEnterEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(BaseStrings.password, style: BaseTextStyle.titleTextStyle, textAlign: TextAlign.start),
                    SizedBox(height: 10),
                    BaseCommonTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hint: BaseStrings.enterPassword,
                      textCapitalization: TextCapitalization.none,
                      focusNode: passwordFocus,
                      obscureText: !passwordVisible,
                      obscuringCharacter: "*",
                      maxLines: 1,
                      errorMaxLines: 5,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        child: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return BaseStrings.pleaseEnterPassword;
                        } else if (!BaseValidation().matches(value, r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')) {
                          return 'Password must be at least 8 characters long, a uppercase letter, a lowercase letter, a number, and a special character';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: BaseButtons().button(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            UserLoginRequestModel userLoginRequestModel = UserLoginRequestModel(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                          );
                            context.read<LoginCubit>().userLogin(userLoginRequestModel);
                          }
                        },
                        title: BaseStrings.signIn.toUpperCase(),
                        context: context,
                        isBordered: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: BaseStrings.doNotHaveAccount,
                          style: BaseTextStyle.subtitleTextStyle,
                          children: [
                            TextSpan(
                              text: BaseStrings.signUp,
                              style: BaseTextStyle.titleTextStyle,
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
