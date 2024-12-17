import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrlOld =
      'https://nebulacard.ltmetro.com'; //'https://devapp.tsavaari.com/LTProject';
  static const String _baseUrl = 'https://stage.tsavaari.com';
  static const _amazonUrl = 'https://s3.ap-south-1.amazonaws.com';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint,
      {bool newUrl = true, bool amazonUrl = false}) async {
    final url = newUrl
        ? _baseUrl
        : amazonUrl
            ? _amazonUrl
            : _baseUrlOld;
    final response = await http.get(Uri.parse('$url/$endpoint'));
    // .timeout(const Duration(seconds: 10));
    return amazonUrl
        ? _handleStringResponse(response)
        : _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data, {
    bool newUrl = true,
    dynamic headers,
  }) async {
    final url = newUrl ? _baseUrl : _baseUrlOld;

    final response = await http.post(
      Uri.parse('$url/$endpoint'),
      headers: headers ??
          {
            'Content-Type': 'application/json',
          },
      body: data != null ? json.encode(data) : null,
    );
    // .timeout(const Duration(seconds: 10));
    print('------------------------------------------------------');
    print('headers : $headers');
    print('payload : $data');
    print('response: ${response.body}');
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    // .timeout(const Duration(seconds: 10));
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    // .timeout(const Duration(seconds: 10));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      var res = response.body;
      if (response.body[0] == '[' || response.body[0] != '{') {
        res = '{"response": ${response.body}}';
      }
      return json.decode(res);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Map<String, dynamic> _handleStringResponse(http.Response response) {
    if (response.statusCode == 200) {
      var res = response.body;
      if (response.body[0] == '[' || response.body[0] != '{') {
        res = '{"response": "${response.body}"}';
      }
      return json.decode(res);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
