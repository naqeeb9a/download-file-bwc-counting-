import 'dart:io';

import 'package:downloadfile/MVVM/Models/details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class CapturedFiles extends ChangeNotifier {
  final List<CaptureFile?> _captureFileList = [];
  List<CaptureFile?> get captureFileList => _captureFileList;
  void enrollDataFile(CaptureFile? captureFile) {
    int index = _captureFileList.indexWhere((element) =>
        element!.detailsModel.data!.verification!.id ==
        captureFile!.detailsModel.data!.verification!.id);
    if (index != -1) {
      _captureFileList[index]!.rackNum = captureFile!.rackNum;
      _captureFileList[index]!.serialNum = captureFile.serialNum;
      return;
    }
    _captureFileList.add(captureFile);
  }

  void resetDataFile() {
    _captureFileList.clear();
  }

  Future<void> exportFileToExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 20;
    globalStyle.bold = true;
    globalStyle.indent = 1;
    globalStyle.hAlign = HAlignType.left;
    globalStyle.vAlign = VAlignType.bottom;
    globalStyle.rotation = 90;
    globalStyle.borders.all.lineStyle = LineStyle.thick;
    sheet.getRangeByName('A1').setText('ID');
    sheet.getRangeByName('B1').setText('Member name');
    sheet.getRangeByName('C1').setText('Project name');
    sheet.getRangeByName('D1').setText('Registration number');
    sheet.getRangeByName('E1').setText('Form no');
    sheet.getRangeByName('F1').setText('Plot size');
    sheet.getRangeByName('G1').setText('Member Cnic');
    sheet.getRangeByName('H1').setText('Rack Number');
    sheet.getRangeByName('I1').setText('Custom Serial Number');
    sheet.getRangeByName('J1').setText('System Serial Number');
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    for (var i = 2; i <= _captureFileList.length + 1; i++) {
      sheet.getRangeByName("A$i").setText(_captureFileList[i - 2]!
          .detailsModel
          .data!
          .verification!
          .id
          .toString()
          .toString());
      sheet.getRangeByName("B$i").setText(_captureFileList[i - 2]!
              .detailsModel
              .data!
              .verification!
              .memberName ??
          "".toString());
      sheet.getRangeByName("C$i").setText(_captureFileList[i - 2]!
          .detailsModel
          .data!
          .verification!
          .societyName);
      sheet.getRangeByName("D$i").setText(
          _captureFileList[i - 2]!.detailsModel.data!.verification!.regNumber ??
              "".toString());
      sheet.getRangeByName("E$i").setText(
          _captureFileList[i - 2]!.detailsModel.data!.verification!.formNo ??
              "".toString());
      sheet.getRangeByName("F$i").setText(
          _captureFileList[i - 2]!.detailsModel.data!.verification!.plotSize ??
              "".toString());
      sheet.getRangeByName("G$i").setText(_captureFileList[i - 2]!
              .detailsModel
              .data!
              .verification!
              .memberCnic ??
          "".toString());
      sheet.getRangeByName("H$i").setText(_captureFileList[i - 2]!.rackNum);
      sheet.getRangeByName("I$i").setText(_captureFileList[i - 2]!.serialNum);
      sheet.getRangeByName("J$i").setText(_captureFileList[i - 2]
          ?.detailsModel
          .data
          ?.verification
          ?.serialNo
          .toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    Directory tempDir = await getTemporaryDirectory();
    File savefile = await File('${tempDir.path}/AddingTextNumberDateTime.xlsx')
        .writeAsBytes(bytes);
    OpenResult result = await OpenFilex.open(savefile.path);
    Fluttertoast.showToast(msg: result.message);
  }
}

class CaptureFile {
  String rackNum;
  String serialNum;
  DetailsModel detailsModel;
  CaptureFile(this.detailsModel, this.rackNum, this.serialNum);
}
