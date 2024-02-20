import 'package:http/http.dart' as http;

Future<void> login(String username, String password) async {
  const String apiUrl = 'http://192.168.103.89:3000/api/auth/login';
  try {
    print(username+"    "+password);
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      print("Login succesful");
      print(response);
    } else {
      print("failed");
    }
  } catch (e) {
    print(e);
  }
}
