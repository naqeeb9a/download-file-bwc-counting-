import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:downloadfile/MVVM/Views/login_view.dart';
import 'package:downloadfile/Provider/user_data_provider.dart';
import 'package:downloadfile/Screens/LockScreen/lock_screen.dart';
import 'package:downloadfile/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageDecider extends StatefulWidget {
  const PageDecider({super.key});

  @override
  State<PageDecider> createState() => _PageDeciderState();
}

class _PageDeciderState extends State<PageDecider> {
  @override
  void initState() {
    decidePage();
    super.initState();
  }

  decidePage() async {
    String? userData = await context.read<UserDataProvider>().getUserData();
    if (userData == null) {
      pushPage(const Login(), userData);
    } else {
      pushPage(const LockScreen(), userData);
    }
  }

  void pushPage(Widget page, String? userData) {
    if (userData != null) {
      context.read<UserDataProvider>().updateData(loginModelFromJson(userData));
    }
    KRoutes.pushAndRemoveUntil(context, page);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
