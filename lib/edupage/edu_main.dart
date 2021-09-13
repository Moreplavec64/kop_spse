// ignore: import_of_legacy_library_into_null_safe
//import 'package:requests/requests.dart';

//import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

class EduPage {
  final String school;
  final String username;
  final String password;
  bool isLoggedIn = false;

  EduPage(this.school, this.username, this.password);

  void login() async {
    String requestUrl = 'https://$school.edupage.org/login/index.php';
    try {
      final r = await http.get(Uri.parse(requestUrl));

      // x final r = await Requests.get(requestUrl);
      //dev.log(r.content());

      final tokenRegex = RegExp(r'(?<=name="csrfauth" value=")(.*)(?=">)',
          caseSensitive: true, multiLine: false);
      final csrfToken = tokenRegex.stringMatch(r.body);

      print('CSRF TOKER : ' + csrfToken.toString());

      print(csrfToken.toString().length);

      final Uri loginRequestUrl =
          Uri.parse("https://$school.edupage.org/login/edubarLogin.php");

      Map<String, String> parameters = {
        "username": username,
        "password": password,
        "csrfauth": csrfToken.toString(),
      };

      final loginResponse = await http.post(loginRequestUrl, body: parameters);

      print(loginResponse.body);
      print(loginResponse.contentLength);

      /*

      final response = await Requests.post(
        loginRequestUrl,
        queryParameters: parameters,
      );

      response.raiseForStatus();

      print(response.content());
      print(parameters);*/

    } catch (e) {
      print('oops');
      print(e.toString());
    }
  }

  /* init
  def __init__(self, school, username, password):
        self.school = school
        self.username = username
        self.password = password
        self.is_logged_in = False
        self.session = requests.session()

        # Set a timeout for all requests made with this session
        self.session.request = functools.partial(self.session.request, timeout = 2)
  */

  /* login
  def login(self):
        # We first have to make a request to index.php to get the csrf token
        request_url = f"https://{self.school}.edupage.org/login/index.php"

        csrf_response = self.session.get(request_url).content.decode()

        # Parse the token from the HTML
        csrf_token = csrf_response.split(
            "name=\"csrfauth\" value=\"")[1].split("\"")[0]

        # Now is everything the same as in the first approach, we just add the csrf token
        parameters = {
            "username": self.username,
            "password": self.password,
            "csrfauth": csrf_token
        }
        request_url = f"https://{self.school}.edupage.org/login/edubarLogin.php"

        response = self.session.post(request_url, parameters)

        if "bad=1" in response.url:
            raise BadCredentialsException()

        try:
            self.parse_login_data(response.content.decode())
        except (IndexError, TypeError):
            raise LoginDataParsingException()

        return True
  */
}
