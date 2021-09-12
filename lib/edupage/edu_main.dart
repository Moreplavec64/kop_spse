// ignore: import_of_legacy_library_into_null_safe
import 'package:requests/requests.dart';
import 'dart:developer' as dev;

class EduPage {
  final String school;
  final String username;
  final String password;
  bool isLoggedIn = false;

  EduPage(this.school, this.username, this.password);

  void initRequest() async {
    String requestUrl = 'https://$school.edupage.org/login/index.php';
    try {
      final r = await Requests.get(requestUrl);
      r.raiseForStatus();
      dev.log(r.content());
      print('done');
    } catch (e) {
      //print(e.toString());
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
