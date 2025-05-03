import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;

enum APIMethod { get, post, put, patch, delete }

// A class for making API requests
class APIManager {
  static dio.Dio client = dio.Dio();

  final String? baseUrl;

  static APIManager? _instance;

  APIManager._({this.baseUrl});

  factory APIManager.getInstance({String? baseUrl}) {
    if (_instance != null) return _instance!;
    assert(baseUrl != null);
    _instance = APIManager._(baseUrl: baseUrl);
    return _instance!;
  }

  static void dispose() {
    _instance = null;
  }

  Future<dio.Response?> request(
      String endPoint,
      Function(String) error, {
        Function? noInternet,
        APIMethod method = APIMethod.get,
        Object? data,
        String? token,
      }) async {
    final isInternet = await checkInternet();
    if (!isInternet) {
      if (noInternet != null) noInternet();
      return null;
    }

    final url = baseUrl! + endPoint;
    if (token != null) {
      client.options.headers["Authorization"] = token;
    }

    try {
      late dio.Response response;
      switch (method) {
        case APIMethod.get:
          response = await client.get(url);
          break;
        case APIMethod.post:
          response = await client.post(url, data: data);
          break;
        case APIMethod.put:
          response = await client.put(url, data: data);
          break;
        case APIMethod.patch:
          response = await client.patch(url, data: data);
          break;
        case APIMethod.delete:
          response = await client.delete(url);
          break;
      }
      return response;
    } on dio.DioException catch (e) {
      log(e.toString());
      error(handleResponse(e));
      return null;
    }
  }

  String handleResponse(dio.DioException e) {
    switch (e.type) {
      case dio.DioExceptionType.badResponse:
        return 'Bad Response';
      case dio.DioExceptionType.badCertificate:
        return 'Bad Certificate';
      case dio.DioExceptionType.connectionTimeout:
        return 'Connection Timeout';
      case dio.DioExceptionType.connectionError:
        return 'Connection Error';
      case dio.DioExceptionType.receiveTimeout:
        return 'Receive Timeout';
      case dio.DioExceptionType.cancel:
        return 'Request Cancelled';
      case dio.DioExceptionType.sendTimeout:
        return 'Send Timeout';
      case dio.DioExceptionType.unknown:
      default:
        return 'Unexpected Error';
    }
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.ethernet)) {
    return true;
  }
  return false;
}