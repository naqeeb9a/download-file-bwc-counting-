import 'package:downloadfile/Api/functionality.dart';
import 'package:downloadfile/MVVM/Views/page_decider.dart';
import 'package:downloadfile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/login_model.dart';
import '../../Provider/user_data_provider.dart';
import '../../Widgets/custom_app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../utils/app_routes.dart';
import '../../Screens/QRScreen/qr_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _animationController?.forward();

    super.initState();
  }

  logout() {
    context.read<UserDataProvider>().clearUserData();
    KRoutes.pushAndRemoveUntil(context, const PageDecider());
  }

  @override
  Widget build(BuildContext context) {
    LoginModel? userData = context.read<UserDataProvider>().userData;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: "BWC Verification",
          appBar: AppBar(),
          widgets: [
            IconButton(
                onPressed: () async {
                  SharedPreferences user =
                      await SharedPreferences.getInstance();
                  user.clear();
                  logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: primaryColor,
                ))
          ],
          appBarHeight: 50,
        ),
        body: homeView(userData));
  }

  Widget homeView(LoginModel? userData) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                width: MediaQuery.of(context).size.width / 3,
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              LottieBuilder.asset(
                "assets/qr.json",
                width: MediaQuery.of(context).size.width / 1.5,
                repeat: false,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                buttonColor: primaryColor,
                text: "Scan QR",
                function: () {
                  KRoutes.push(context, const QRScreen());
                },
                textColor: kWhite,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(text: "Or"),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                buttonColor: primaryColor,
                text: "Enter Reg No",
                function: () {
                  Functionality.openDialogue(context, _controller, false);
                },
                textColor: kWhite,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
