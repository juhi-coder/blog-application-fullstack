import 'package:blog_aplication_flutter/app/app.router.dart';
import 'package:blog_aplication_flutter/services/api_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final _apiService = ApiService();
  final _navigationService = NavigationService();

  Future<void> signup(String fullname, String email, String password) async {
    setBusy(true);

    if (await _apiService.signup(fullname, email, password)) {
      _navigationService.clearStackAndShow(Routes.loginView);
    }
    setBusy(false);
  }
}
