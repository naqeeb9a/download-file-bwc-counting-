import 'package:downloadfile/MVVM/Models/details_model.dart';
import 'package:downloadfile/MVVM/Models/model_error.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/MVVM/Repo/details_service.dart';
import 'package:flutter/widgets.dart';

class DetailsModelView extends ChangeNotifier {
  DetailsModel? _detailsModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  DetailsModel? get detailsModel => _detailsModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPostModelList(DetailsModel detailsModel) {
    _detailsModel = detailsModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future<void> getDetails(String code, String id, String token) async {
    setLoading(true);
    var response = await DetailsService.getDetails(code, id, token);
    if (response is Success) {
      setPostModelList(response.response as DetailsModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
