import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  //i made this stateful so we can chuck in patient details but atm it just has the title lifesavers
  const MyDataPage({super.key, required this.title});
  final String title;
  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data page'),
      ),
    );
  }
}

void fetchUser() async {
  //maybe feed in the user id later idk
  const url =
      '***REMOVED***/GetPatientData?UserId=BHL33M&fbclid=IwAR376I2nF832P7srLAglRfsJV_ENvLJ1FDYYjLaN7j3UUXro544mD1fvwH8';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
}
