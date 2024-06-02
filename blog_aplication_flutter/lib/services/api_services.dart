import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class ApiService {
  final DialogService _dialogService = DialogService();
  late SharedPreferences prefs;

  ApiService() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final String url = 'https://blog-application-backend-9ntw.onrender.com';

  Future<dynamic> signup(String fullname, String email, String password) async {
    final response = await http.post(
      Uri.parse("$url/user/signup"),
      headers: <String, String>{
        "Content-Type": "application/json;charset=UTF-8"
      },
      body: jsonEncode(<String, dynamic>{
        "fullname": fullname,
        "email": email,
        "password": password
      }),
    );

    if (response.statusCode == 201) {
      await _dialogService.showDialog(
        title: 'Success',
        description: 'User created successfully',
        buttonTitle: 'OK',
      );
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      await _dialogService.showDialog(
        title: 'Error',
        description: responseBody['message'] ?? 'Failed to add the data',
        buttonTitle: 'OK',
      );
      return false;
    }
  }

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$url/user/login"),
      headers: <String, String>{
        "Content-Type": "application/json;charset=UTF-8"
      },
      body: jsonEncode(<String, dynamic>{"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      await _dialogService.showDialog(
        title: 'Success',
        description: 'login successfully',
        buttonTitle: 'OK',
      );
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      await _dialogService.showDialog(
        title: 'Error',
        description: responseBody['message'] ?? 'login failed',
        buttonTitle: 'OK',
      );
      return false;
    }
  }

  Future<dynamic> addBlog(String title, String body, File coverImageUrl) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$url/blog/add-blog"),
      )
        ..fields['title'] = title
        ..fields['body'] = body
        ..files.add(
          await http.MultipartFile.fromPath(
            'coverImageUrl',
            coverImageUrl.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        await _dialogService.showDialog(
          title: 'Success',
          description: 'blogs added successfully',
          buttonTitle: 'OK',
        );
        return true; // Return true on success
      } else {
        return false; // Return false on failure
      }
    } catch (e) {
      return false; // Return false if an exception occurs
    }
  }

  Future<dynamic> fetchBlogs() async {
    final response = await http.get(Uri.parse('$url/blog/get-blog'));

    try {
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception("failed to get the data");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
