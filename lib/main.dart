import 'package:flutter/material.dart';
import 'package:kop_spse/edupage/edu_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    EduPage e = EduPage('spojenaskolanz', 'AdamHadar', '5RDVUDPSPA');
    //e.login();

    e.headerToCookies({
      'connection': 'Upgrade',
      'last-modified': 'Tue, 14 Sep 2021 05:34:16 GMT',
      'cache-control':
          ' no-store, no-cache, must-revalidate, post-check=0, pre-check=0',
      'set-cookie':
          'PHPSESSID=82cc5aea1383aa1f0c29568a34a49e43; path=/; secure; HttpOnly,hsid=94cad1556e9fd056c30e227cd307a252653422a1; path=/; secure,edid=W0mTqe4bJ5VgvHc7zMySAb2KOPuYa8; expires=Fri, 13-Sep-2024 05:34:16 GMT; Max-Age=94608000; path=/; secure; HttpOnly',
      'transfer-encoding': 'chunked',
      'date': 'Tue, 14 Sep 2021 05:34:16 GMT',
      'content-encoding': 'gzip',
      'vary': 'Accept-Encoding',
      'strict-transport-security': 'max-age=63072000;',
      'referrer-policy': 'same-origin',
      'expires': 'Mon, 26 Jul 1997 05:00:00 GMT'
    });
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('AAAAAAAAAA'),
      ),
    );
  }
}
