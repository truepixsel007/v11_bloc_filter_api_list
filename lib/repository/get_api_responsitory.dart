import 'dart:async'; // Needed for TimeoutException
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/api_model.dart';

class GetApiRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<ApiModel>> fetchApi() async {
    try {
      final response = await http
          .get(
            Uri.parse(_baseUrl),
            headers: {
              'User-Agent': 'Mozilla/5.0', // <- Required by some networks
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((e) {
          return ApiModel(
            postId: e['postId'] as int,
            id: e['id'] as int,
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      } else {
        throw HttpException(
          'Failed to fetch data. Status Code: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    } on TimeoutException {
      throw Exception('The connection has timed out.');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
