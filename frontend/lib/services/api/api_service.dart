import 'dart:convert';
import 'package:frontend/utils/exceptions.dart';
import 'package:http/http.dart';

typedef TokenProvider = String? Function();

class ApiService {
  final Client _client;

  ApiService(this._client);

  TokenProvider? _tokenProvider;
  set tokenProvider(TokenProvider token) => _tokenProvider = token;

  Future<Map<String, String>> _header() async {
    final headers = {'Content-Type': 'application/json'};
    final authHeader = _tokenProvider?.call();
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
    final response = await _client.post(
      Uri.parse(path),
      headers: await _header(),
    );
    return _handleRequest(response);
  }

  Future<dynamic> _handleRequest(Response res) async {
    final status = res.statusCode;

    if (res.body.isEmpty) return NotFoundException();

    switch (status) {
      case 200: return res;
      case 201: return res;
      case 202: return res;
      case 204: return res;

      case 400: return ServerRequestException();
      case 401: return SessionException();
      case 403: return ForbiddenException();
      case 404: return NotFoundException();
      case 408: return ServerTimeoutException();
      case 409: return DuplicateException();
      case 429: return TooManyRequestsException();
      case 500: return ServerException();

      default: return UnexpectedErrorException();
    }
  }
}
