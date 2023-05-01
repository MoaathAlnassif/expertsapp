import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/models/user.dart';
import 'package:untitled4/shared/network/remote/Constant/error_string.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';

import 'package:untitled4/shared/network/remote/api_response.dart';

registerUser(String name, String email, String password) async {
  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.post(Uri.parse(RegisterURL),
        headers: {'Accept': 'application/json'},
        body: {'name': name, 'email': email, 'password': password});
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = User.fromJson(jsonDecode(res.body));

          break;
        }
      case 201:
        {
          response.data = User.fromJson(jsonDecode(res.body));
          break;
        }
      case 404:
        {
          response.error = jsonDecode(res.body)["data"];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body);
          break;
        }
      default:
        {
          response.error = somethingError;
        }
    }
  } catch (e) {
    response.error = serverError;
  }
  return response;
}

registerExpert(String name, String email, String password) async {
  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.post(Uri.parse(RegisterExpertURL),
        headers: {'Accept': 'application/json'},
        body: {'name': name, 'email': email, 'password': password});
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = User.fromJson(jsonDecode(res.body));

          break;
        }
      case 201:
        {
          response.data = User.fromJson(jsonDecode(res.body));
          break;
        }
      case 404:
        {
          response.error = jsonDecode(res.body)["data"];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body);
          break;
        }
      default:
        {
          response.error = somethingError;
        }
    }
  } catch (e) {
    response.error = serverError;
  }
  return response;
}

login(String email, String password) async {
  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.post(Uri.parse(LoginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = User.fromJson(jsonDecode(res.body));

          break;
        }
      case 201:
        {
          response.data = User.fromJson(jsonDecode(res.body));
          break;
        }
      case 404:
        {
          response.error = jsonDecode(res.body)["data"];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body);
          break;
        }
      default:
        {
          response.error = somethingError;
        }
    }
  } catch (e) {
    response.error = serverError;
  }
  return response;
}

createExpert({
  @required String name,
  @required String address,
  @required String phone,
  @required String price,
  @required String start_time,
  @required String end_time,
  @required String Daysspace,
  @required String category,
  @required String photo,
  @required String skills,
}) async {
  String token = await getToken();
  ApiResponse response = ApiResponse();

  try {
    http.Response res = await http.post(Uri.parse(CreateExpertURL), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'address': address,
      'phone': phone,
      'price': price,
      'start_time': start_time,
      'end_time': end_time,
      'Daysspace': Daysspace,
      'category': category,
      'photo': photo,
      'skills': skills
    });

    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = Expert.fromJson(jsonDecode(res.body)['data']);

          break;
        }
      case 201:
        {
          response.data = Expert.fromJson(jsonDecode(res.body));
          break;
        }
      case 404:
        {
          response.error = jsonDecode(res.body)["data"];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body);
          break;
        }
      default:
        {
          response.error = somethingError;
        }
    }
  } catch (e) {
    response.error = serverError;
  }
  return response;
}

logOut() async {
  String token = await getToken();
  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.delete(Uri.parse(LogOutURL),
        headers: {'Authorization': 'Bearer $token'});
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body);
          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body)["data"];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body);
          break;
        }
      default:
        {
          response.error = somethingError;
        }
    }
  } catch (e) {
    response.error = serverError;
  }
  return response;
}

getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('token');
  return token;
}
String getStringImage(File file) {
  if (file == null) return null ;
  return base64Encode(file.readAsBytesSync());
}
