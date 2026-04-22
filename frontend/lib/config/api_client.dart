import 'package:http/http.dart';

class DefaultClient extends BaseClient{
  final Client _client;
  bool _isClosed = false;

  DefaultClient(this._client);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (_isClosed) throw ClientException("Client has been closed. No further requests allowed.");

    try {
      return await _client.send(request);
    } catch (e) {
      _client.close();
      rethrow;
    }
  }

  @override
  void close() => {_isClosed = true, _client.close()};
}

class AuthenticatedClient extends BaseClient{
  final Client _client;
  final String _authToken;

  bool _isClosed = false;

  AuthenticatedClient(this._client, this._authToken);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (_isClosed) throw ClientException("Client has been closed. No further requests allowed.");

    request.headers['Authorization'] = 'Bearer $_authToken';
    request.headers['Content-Type'] = 'application/json';

    try {
      return await _client.send(request);
    } catch (e) {
      _client.close();
      rethrow;
    }
  }

  @override
  void close() => {_isClosed = true, _client.close()};
}