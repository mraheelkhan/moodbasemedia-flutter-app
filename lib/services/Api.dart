import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:moodbasemedia/models/OwnerResponse.dart';
import 'package:moodbasemedia/models/TrackReponse.dart';

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl =
      // 'http://192.168.10.17/Laravel-Flutter-Course-API/public/api/';
      // 'https://f082-203-135-44-46.ngrok.io/api/';
      'https://moodbasemedia.raheelsays.com/api/';

  /* ##### Model Track #### */
  Future<TrackResponse> fetchTracks() async {
    TrackResponse _owner;
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'medias'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    var owner = jsonDecode(response.body);

    _owner = TrackResponse.fromJson(owner);
    return _owner;
  }

  /* ##### Model Track By Mood #### */
  Future<TrackResponse> fetchTracksByMood(String mood) async {
    TrackResponse _owner;
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'medias/' + mood),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    var owner = jsonDecode(response.body);

    _owner = TrackResponse.fromJson(owner);
    print(_owner);
    return _owner;
  }

  /// #### Register and Login ####
  Future<String> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    String uri = baseUrl + 'auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    return response.body;
  }

  Future<String> login(String email, String password, String deviceName) async {
    String uri = baseUrl + 'auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    print('debugger');
    print(response.body);
    return response.body;
  }
}
