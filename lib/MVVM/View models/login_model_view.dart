import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:downloadfile/MVVM/Models/model_error.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/MVVM/Repo/login_service.dart';
import 'package:flutter/widgets.dart';

class LoginModelView extends ChangeNotifier {
  LoginModel? _loginModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  LoginModel? get loginModel => _loginModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPostModelList(LoginModel loginModel) {
    _loginModel = loginModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future<void> loginUser(String username, String password) async {
    setLoading(true);
    var response = await LoginService.loginUser(username, password);
    if (response is Success) {
      setPostModelList(response.response as LoginModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
