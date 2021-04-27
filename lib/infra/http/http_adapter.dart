import 'dart:convert';
import 'package:http/http.dart';

import 'package:mesa_news/data/http/http_client.dart';
import 'package:mesa_news/data/http/http_error.dart';
import 'package:meta/meta.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({@required String url, @required String method, Map body, Map headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'Content-type': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response> futureResponse;
    try {
      if (method == 'post') {
        futureResponse = client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == 'put') {
        futureResponse = client.put(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(Duration(seconds: 20));
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 201:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
