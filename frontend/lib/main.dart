import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'LifeSavers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ProfileBox(), ProfileBox(), ProfileBox(), ProfileBox()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProfileBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell should make card clickable
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyDataPage(title: 'LifeSavers')),
        );
      },
      child: Card(
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(30.0),
                child: const Icon(Icons.account_circle, size: 100),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ))),
            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text("Patient Name/ Number"),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Text("Status"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key, required this.title});
  final String title;
  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  late Future<User> futureUser;
  @override
  void initState() {
    //we may have a problem with reloading data w init
    super.initState();
    futureUser = fetchUser(); //we could put user id here i think
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data page'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.longitude);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<User> fetchUser() async {
  //maybe feed in the user id later idk
  const url =
      'https://sog1p6r867.execute-api.ap-southeast-2.amazonaws.com/Production/GetPatientData?UserId=BHL33M&fbclid=IwAR376I2nF832P7srLAglRfsJV_ENvLJ1FDYYjLaN7j3UUXro544mD1fvwH8';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final r = Response.fromJson(jsonDecode(response.body));
    return User.fromJson(r.userData);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Response {
  final String message;
  final Map<String, dynamic> userData;
  const Response({
    required this.message,
    required this.userData,
  });
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      message: json['message'],
      userData: json['data'],
    );
  }
}

class User {
  final String userId;
  final String avatarImage;
  final String fullName;
  final String longitude;
  final String latitude;
  final String dateTime;
  final double heartRate;
  final double steps;
  final String sleepStatus;

  const User({
    required this.userId,
    required this.avatarImage,
    required this.fullName,
    required this.longitude,
    required this.latitude,
    required this.dateTime,
    required this.heartRate,
    required this.steps,
    required this.sleepStatus,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['UserId'],
      avatarImage: json['AvatarImage'],
      fullName: json['FullName'],
      longitude: json['Longitude'],
      latitude: json['Latitude'],
      dateTime: json['DateTime'],
      heartRate: json['HeartRate'],
      steps: json['Steps'],
      sleepStatus: json['SleepStatus'],
    );
  }
}
