import 'dart:convert';
import 'dart:io';
import 'package:blog_aplication_flutter/app/app.router.dart';
import 'package:blog_aplication_flutter/services/api_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  String? userFullName;
  final _apiService = ApiService();
  final _navigationService = NavigationService();

  XFile? pickedFile;
  List<dynamic> blogs = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> init() async {
    await fetchBlogs();
  }

  Future<void> pickFile() async {
    final choosePickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (choosePickedFile != null) {
      pickedFile = choosePickedFile;
      notifyListeners();
    }
  }

  Future<void> addBlog(String title, String body, File image) async {
    setBusy(true);
    if (await _apiService.addBlog(title, body, image)) {
      _navigationService.clearStackAndShow(Routes.homeView);
    }
    setBusy(false);
  }

  Future<void> fetchBlogs() async {
    try {
      blogs = await _apiService.fetchBlogs();
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      print('Error fetching blogs: $e');
      // Handle error appropriately, e.g., show a message to the user
    }
  }
}
