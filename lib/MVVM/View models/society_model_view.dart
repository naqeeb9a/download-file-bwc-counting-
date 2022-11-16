import 'package:downloadfile/MVVM/Models/model_error.dart';
import 'package:downloadfile/MVVM/Models/society_model.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/MVVM/Repo/society_service.dart';
import 'package:flutter/widgets.dart';

class SocietyModelView extends ChangeNotifier {
  SocietyModel? _societyModel;
  bool _loading = false;
  ModelError? _modelError;

  SocietyModelView() {
    getSocieties();
  }

  bool get loading => _loading;
  SocietyModel? get societyModel => _societyModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPostModelList(SocietyModel societyModel) {
    _societyModel = societyModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future<void> getSocieties() async {
    setLoading(true);
    var response = await SocietyService.getSocieties();
    if (response is Success) {
      setPostModelList(response.response as SocietyModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
