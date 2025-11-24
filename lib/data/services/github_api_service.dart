import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubApiService {
  final String _baseUrl = "https://api.github.com/users/";

  Future<Map<String, dynamic>> getGithubStats(String username) async {
    if (username.isEmpty) {
      throw Exception('Ім\'я користувача GitHub не вказано');
    }

    final url = Uri.parse('$_baseUrl$username');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else {
        throw Exception('Не вдалося завантажити статистику. Користувач "$username" не знайдений (код: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Помилка мережі: $e');
    }
  }
}