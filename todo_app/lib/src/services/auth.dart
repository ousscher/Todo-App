import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  static String ipAdress = "192.168.176.89";
  static Future<String> login(String username, String password) async {
    final String apiUrl = 'http://$ipAdress:3000/api/auth/login';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        String token = jsonDecode(response.body)['token'];
        print(token);
        return token;
      } else {
        print('Login failed. Status code: ${response.statusCode}');
        throw Exception('${jsonDecode(response.body)['message']}');
      }
  }

  static Future<String> signupAndLogin(String username, String password) async {
    final String apiUrlSignup = 'http://$ipAdress:3000/api/auth/register';

      final responseSignup = await http.post(
        Uri.parse(apiUrlSignup),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );

      if (responseSignup.statusCode == 200) {
        print('Signup successful');
        // Call login after successful signup
        return await login(username, password);
      } else {
        throw Exception('${jsonDecode(responseSignup.body)['message']}');
      }
  }
}
