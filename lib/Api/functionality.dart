import 'package:downloadfile/MVVM/View%20models/details_model_view.dart';
import 'package:downloadfile/utils/app_routes.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../Provider/user_data_provider.dart';
import '../MVVM/Views/detail_screen.dart';
import '../Widgets/widget.dart';
import '../utils/utils.dart';

class Functionality {
  static openDialogue(
      BuildContext context, TextEditingController controller, bool check) {
    String? societyId =
        Provider.of<SelectedSoceityProvider>(context, listen: false).id;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  "assets/write.json",
                  width: 200,
                  repeat: false,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: "Enter Registration Number")),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormTextField(
                  controller: controller,
                  suffixIcon: const Icon(Icons.edit),
                  function: (value) {
                    if (value!.isEmpty) {
                      return "Field can't be Empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: "Get results",
                  textColor: kWhite,
                  function: () async {
                    if (controller.text.isEmpty) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: "Field can't be empty",
                          backgroundColor: kblack,
                          lottieAsset: "assets/error.json");
                    } else {
                      KRoutes.pop(context);
                      if (check) {
                        KRoutes.pop(context);
                      }
                      context.read<DetailsModelView>().setModelError(null);
                      context.read<DetailsModelView>().getDetails(
                          "reg_no=${controller.text}",
                          societyId.toString(),
                          context
                              .read<UserDataProvider>()
                              .userData!
                              .data!
                              .oauth!
                              .accessToken!);
                      KRoutes.push(
                          context,
                          DetailScreen(
                            code: "reg_no=${controller.text}",
                            id: societyId,
                          ));
                      controller.clear();
                    }
                  },
                  buttonColor: primaryColor,
                )
              ],
            ),
          );
        });
  }
}
