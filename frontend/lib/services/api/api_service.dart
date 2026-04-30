import 'dart:convert';
import 'package:frontend/services/shared_preferences.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:http/http.dart';

class ApiService {
  final Client _client;
  final SharedPreferenceService _storage;

  ApiService(this._client, this._storage);

  String? get token => _storage.getToken();

  Future<Map<String, String>> _header() async {
    var headers = {'Content-Type': 'application/json'};
    var authHeader = token;
    if (authHeader != null) headers.addAll({'Authorization': authHeader});
    return headers;
  }

  Future<dynamic> get(
    String path
  ) async {
    final response = await _client.get(
      Uri.parse(path),
      headers: await _header()
    );
    return _handleRequest(response);
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> data
  ) async {
    final response = await _client.post(
      Uri.parse(path),
      headers: await _header(),
      body: jsonEncode(data)
    );
    return _handleRequest(response);
  }

  Future<dynamic> put(
    String path,
    Map<String, dynamic> data
  ) async {
    final response = await _client.put(
      Uri.parse(path),
      headers: await _header(),
      body: jsonEncode(data)
    );
    return _handleRequest(response);
  }

  Future<dynamic> delete(
    String path
  ) async {
    final response = await _client.delete(
      Uri.parse(path),
      headers: await _header(),
    );
    return _handleRequest(response);
  }

  Future<dynamic> _handleRequest(Response res) async {
    final status = res.statusCode;
    switch (status) {
      case 200: return res;
      case 201: return res;
      case 202: return res;
      case 204: return res;

      case 400: throw ServerRequestException();
      case 401: throw CredentialException();
      case 403: throw ForbiddenException();
      case 404: throw NotFoundException();
      case 408: throw ServerTimeoutException();
      case 409: throw DuplicateException();
      case 429: throw TooManyRequestsException();
      case 500: throw ServerException();

      default: throw UnexpectedErrorException();
    }
  }
}
