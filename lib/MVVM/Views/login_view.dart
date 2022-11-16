import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:downloadfile/MVVM/View%20models/login_model_view.dart';
import 'package:downloadfile/Provider/user_data_provider.dart';
import 'package:downloadfile/MVVM/Views/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Widgets/widget.dart';
import '../../utils/app_routes.dart';
import '../../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginModelView loginModelView = context.watch<LoginModelView>();
    return Scaffold(
        appBar: BaseAppBar(
            title: "Login",
            appBar: AppBar(),
            widgets: const [],
            appBarHeight: 50),
        backgroundColor: Colors.white,
        body: loginView(loginModelView));
  }

  Widget loginView(LoginModelView loginModelView) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/logo.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: CustomText(text: "Username"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: _username,
                      suffixIcon: const Icon(Icons.person_outline),
                      keyboardtype: TextInputType.text,
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field can't be empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: CustomText(text: "Password"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                    controller: _password,
                    isPass: true,
                    suffixIcon: const Icon(Icons.visibility_outlined),
                    function: (value) {
                      if (value!.isEmpty) {
                        return "Field can't be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: loginModelView.loading
                          ? const CircularProgressIndicator.adaptive()
                          : CustomButton(
                              buttonColor: primaryColor,
                              textColor: Colors.white,
                              text: "login",
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  loginModelView.setModelError(null);
                                  await context
                                      .read<LoginModelView>()
                                      .loginUser(_username.text, _password.text)
                                      .then((value) async {
                                    if (loginModelView.modelError != null) {
                                      Fluttertoast.showToast(
                                          msg: loginModelView
                                              .modelError!.errorResponse
                                              .toString());
                                    } else {
                                      await updateData(
                                          loginModelView.loginModel!);
                                      pushPage();
                                    }
                                  });
                                }
                              },
                            )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateData(LoginModel response) async {
    await context.read<UserDataProvider>().saveUserData(response);
  }

  popPage() {
    KRoutes.pop(context);
  }

  pushPage() {
    KRoutes.pushAndRemoveUntil(context, const HomeScreen());
  }
}
