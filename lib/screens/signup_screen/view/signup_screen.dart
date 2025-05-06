import 'package:ealphabits_practical/screens/login_screen/view/login_screen.dart';
import 'package:ealphabits_practical/screens/signup_screen/model/user_signup_request_model.dart';
import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../utils/base_button.dart';
import '../../../utils/base_common_text_field.dart';
import '../../../utils/base_text_style.dart';
import '../../../utils/base_validation.dart';
import '../bloc/signup_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  final TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  final SignupCubit signupCubit = SignupCubit();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlocProvider(
        create: (context) => signupCubit,
        child: BlocConsumer<SignupCubit, SignupRequestState>(
          listener: (context, state) {
            if (state is SignupRequestSuccess) {
              EasyLoading.dismiss();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            } else if (state is SignupRequestError) {
              EasyLoading.dismiss();
              BaseWidgets.toastMessage(title: state.message);
            }
          },
          builder: (context, state) {
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
                            Center(child: Text(BaseStrings.signUp, style: BaseTextStyle.chatListScreenTitle)),
                            SizedBox(height: 60),
                            Text(BaseStrings.name, style: BaseTextStyle.titleTextStyle, textAlign: TextAlign.start),
                            SizedBox(height: 10),
                            BaseCommonTextField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              hint: BaseStrings.enterName,
                              textCapitalization: TextCapitalization.none,
                              focusNode: nameFocus,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return BaseStrings.pleaseEnterName;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
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
                                /*else if (BaseValidation().isValidEmail(value)) {
                        return BaseStrings.pleaseEnterValidEmail;
                      }*/
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            Text(BaseStrings.password, style: BaseTextStyle.titleTextStyle, textAlign: TextAlign.start),
                            SizedBox(height: 10),
                            BaseCommonTextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              hint: BaseStrings.pleaseEnterPassword,
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
                                    UserSignUpRequestModel userSignUpRequestModel = UserSignUpRequestModel(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: nameController.text.trim(),
                                    );
                                    try {
                                      context.read<SignupCubit>().signUpUser(userSignUpRequestModel);
                                    } catch (e) {
                                      BaseWidgets.toastMessage(title: e.toString());
                                    }
                                  }
                                },
                                title: BaseStrings.signUp.toUpperCase(),
                                context: context,
                                isBordered: true,
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: BaseStrings.haveAccount,
                                  style: BaseTextStyle.subtitleTextStyle,
                                  children: [
                                    TextSpan(
                                      text: BaseStrings.signIn,
                                      style: BaseTextStyle.titleTextStyle,
                                      recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },

        ),
      ),
    );
  }
}
