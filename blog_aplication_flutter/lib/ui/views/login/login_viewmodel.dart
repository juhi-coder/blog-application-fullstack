import 'package:blog_aplication_flutter/app/app.router.dart';
import 'package:blog_aplication_flutter/services/api_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final ApiService _apiService = ApiService();

  Future<void> login(String email, String password) async {
    setBusy(true);

    if (await _apiService.login(email, password)) {
      _navigationService.clearStackAndShow(Routes.homeView);
    }
    setBusy(false);
  }
}
