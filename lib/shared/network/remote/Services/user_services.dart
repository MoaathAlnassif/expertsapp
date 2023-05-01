import 'dart:convert';

import 'package:untitled4/models/Appointment.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/models/SearchResult.dart';
import 'package:untitled4/models/consulting.dart';
import 'package:untitled4/shared/network/remote/Constant/error_string.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';

import '../api_response.dart';
import 'package:http/http.dart' as http;

import 'AuthServices.dart';

showAllConsulting() async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(AllConsultingURL),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data']
              .map((e) => Consulting.fromJson(e))
              .toList();
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

expertInConsulting(int id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(ExpertInConsultingURL + "$id"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data']
              .map((e) => Expert.fromJson(e))
              .toList();
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

createRating(int expertId, int star) async {
  String token = await getToken();


  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.post(Uri.parse(CreateratingURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'star': star,
      'expert_id': expertId
    });
   // print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data'];

          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body);
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
showRating(int id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(ShowRatingURL + "$id"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data'];

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
createAppointment(var expertId, var totalprice,var time,var date) async {
  String token = await getToken();
  ApiResponse response = ApiResponse();
  try {
    http.Response res = await http.post(Uri.parse(CreateAppointmentURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "data":date,
      "time" :time,
      "expert_id":expertId,
      "totalprice" :totalprice
    }
    );
    // print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = Appointment.fromJson(jsonDecode(res.body)['data']);
          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body);
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

  getAppointment( var id) async {
    ApiResponse response = ApiResponse();
    String token = await getToken();
    try {
      http.Response res = await http.get(
        Uri.parse(GetAppointmentURL+id.toString()),
        headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );
      print(jsonDecode(res.body));
      switch (res.statusCode) {
        case 200:
          {
            response.data = jsonDecode(res.body)['data']
                .map((e) => Appointment.fromJson(e))
                .toList();
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
addFavourite( var id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.post(
      Uri.parse(AddFavouriteURL+id.toString()),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data'];

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
clearFavourite( var id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.post(
      Uri.parse(ClearfavouriteURL+id.toString()),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data'];

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
isFavourite( var id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(isFavouriteURL+id.toString()),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data'];
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
showExpertFavorite() async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(ShowfavouriteURL),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = jsonDecode(res.body)['data']
              .map((e) => Expert.fromJson(e))
              .toList();
          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body)['data'];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body)['data'];
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
search(String quray) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(searchURL+quray),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          if(jsonDecode(res.body)['data'].isNotEmpty) {
            response.data = jsonDecode(res.body)['data']
                .map((e) => SearchResult.fromJson(e))
                .toList();
          }
          else{
            response.data=0;
          }

          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body)['data'];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body)['data'];
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
showExpert(var id) async {
  ApiResponse response = ApiResponse();
  String token = await getToken();
  try {
    http.Response res = await http.get(
      Uri.parse(ProfileexpertURL+id.toString()),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    print(jsonDecode(res.body));
    switch (res.statusCode) {
      case 200:
        {
          response.data = Expert.fromJson(jsonDecode(res.body));
          break;
        }

      case 404:
        {
          response.error = jsonDecode(res.body)['data'];
          break;
        }
      case 400:
        {
          response.error = jsonDecode(res.body)['data'];
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