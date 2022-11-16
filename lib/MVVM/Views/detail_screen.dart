import 'package:cool_alert/cool_alert.dart';
import 'package:downloadfile/Api/functionality.dart';
import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:downloadfile/MVVM/View%20models/details_model_view.dart';
import 'package:downloadfile/Provider/captured_files.dart';
import 'package:downloadfile/Provider/user_data_provider.dart';
import 'package:downloadfile/MVVM/Views/login_view.dart';

import 'package:downloadfile/Widgets/custom_loader.dart';
import 'package:downloadfile/Widgets/widget.dart';
import 'package:downloadfile/utils/app_routes.dart';
import 'package:downloadfile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/QRScreen/qr_screen.dart';

class DetailScreen extends StatefulWidget {
  final String? code;

  const DetailScreen({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginModel? userData = context.read<UserDataProvider>().userData;

    List<CaptureFile?> scannedFiles =
        context.read<CapturedFiles>().captureFileList;
    DetailsModelView detailsModelView = context.watch<DetailsModelView>();
    return WillPopScope(
      onWillPop: () async {
        if (scannedFiles.isNotEmpty) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              text: "If you go back you will lose all Scanned files data",
              cancelBtnText: "No",
              confirmBtnText: "Yes",
              onConfirmBtnTap: () {
                context.read<CapturedFiles>().resetDataFile();
                KRoutes.pop(context);
                KRoutes.pop(context);
              });
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: BaseAppBar(
              title: "Verification Screen",
              appBar: AppBar(),
              leading: InkWell(
                onTap: () {
                  if (scannedFiles.isNotEmpty) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        text:
                            "If you go back you will lose all Scanned files data",
                        cancelBtnText: "No",
                        confirmBtnText: "Yes",
                        onConfirmBtnTap: () {
                          context.read<CapturedFiles>().resetDataFile();
                          KRoutes.pop(context);
                          KRoutes.pop(context);
                        });
                  } else {
                    KRoutes.pop(context);
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: kblack,
                ),
              ),
              automaticallyImplyLeading: true,
              widgets: const [],
              appBarHeight: 50),
          body: detailsView(userData!, detailsModelView, scannedFiles)),
    );
  }

  Widget detailsView(LoginModel userData, DetailsModelView detailsModelView,
      List<CaptureFile?> scannedFiles) {
    if (detailsModelView.loading) {
      return const CustomLoader();
    }
    if (detailsModelView.modelError != null) {
      if (detailsModelView.modelError!.code == 501) {
        logoutUser();
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              detailsModelView.modelError!.code == 100
                  ? "assets/servertimeout.json"
                  : "assets/notVerified.json",
              repeat: false,
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              text: detailsModelView.modelError!.errorResponse.toString(),
              fontsize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                buttonColor: primaryColor,
                text: "Next QR",
                textColor: kWhite,
                function: () {
                  KRoutes.pop(context);

                  KRoutes.push(context, const QRScreen());
                }),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColor: primaryColor,
                text: "Next Reg",
                textColor: kWhite,
                function: () {
                  Functionality.openDialogue(context, _controller, true);
                }),
            const SizedBox(
              height: 20,
            ),
            if (scannedFiles.isNotEmpty)
              CustomButton(
                  buttonColor: primaryColor,
                  text: "Export scanned files   ${scannedFiles.length}",
                  textColor: kWhite,
                  function: () {
                    context.read<CapturedFiles>().exportFileToExcel();
                  }),
          ],
        ),
      );
    }
    context
        .read<CapturedFiles>()
        .enrollDataFile(CaptureFile(detailsModelView.detailsModel!, "", ""));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dataRow(
                "Name:",
                detailsModelView.detailsModel!.data!.verification!.memberName ??
                    ""),
            dataRow(
                "Registration number:",
                detailsModelView.detailsModel!.data!.verification!.regNumber ??
                    ""),
            dataRow(
                "Plot size:",
                detailsModelView.detailsModel!.data!.verification!.plotSize ??
                    ""),
            dataRow(
                "Form no:",
                detailsModelView.detailsModel!.data!.verification!.formNo ??
                    ""),
            dataRow(
                "Cnic:",
                detailsModelView.detailsModel!.data!.verification!.memberCnic ??
                    ""),
            dataRow(
                "Project name:",
                detailsModelView
                        .detailsModel!.data!.verification!.societyName ??
                    ""),
            const CustomText(text: "Rack number"),
            const SizedBox(
              height: 5,
            ),
            FormTextField(
                controller: _controller2,
                keyboardtype: TextInputType.number,
                onchanged: (value) {
                  context.read<CapturedFiles>().enrollDataFile(CaptureFile(
                      detailsModelView.detailsModel!,
                      _controller2.text,
                      _controller3.text));
                },
                suffixIcon: const Icon(Icons.numbers)),
            const SizedBox(
              height: 5,
            ),
            const CustomText(text: "Serial number"),
            const SizedBox(
              height: 5,
            ),
            FormTextField(
                controller: _controller3,
                keyboardtype: TextInputType.number,
                onchanged: (value) {
                  context.read<CapturedFiles>().enrollDataFile(CaptureFile(
                      detailsModelView.detailsModel!,
                      _controller2.text,
                      _controller3.text));
                },
                suffixIcon: const Icon(Icons.numbers)),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColor: primaryColor,
                text: "Next QR",
                textColor: kWhite,
                function: () {
                  KRoutes.pop(context);

                  KRoutes.push(context, const QRScreen());
                }),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColor: primaryColor,
                text: "Next Reg",
                textColor: kWhite,
                invert: true,
                function: () {
                  Functionality.openDialogue(context, _controller, true);
                }),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColor: primaryColor,
                text: "Export scanned files   ${scannedFiles.length}",
                textColor: kWhite,
                invert: true,
                function: () {
                  context.read<CapturedFiles>().exportFileToExcel();
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget dataRow(String text1, String text2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: text1,
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                  maxLines: 5,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: CustomText(
                text: text2,
                fontsize: 18,
                textAlign: TextAlign.end,
                maxLines: 5,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  logoutUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    user.clear();
    logout();
    Fluttertoast.showToast(msg: "Token Expired, Please Login again");
  }

  logout() {
    KRoutes.pushAndRemoveUntil(context, const Login());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
