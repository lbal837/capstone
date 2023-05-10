import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/add_patient_page.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_logout_user_button.dart';
import 'package:frontend/ui/home/widgets/home_profile_box.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';
class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService(userPool);
  List<Patient> patientList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final PatientDefaultRepository patientRepository =
        PatientDefaultRepository();
    patientList = await patientRepository.fetchAllPatients();
    if (patientList.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [FutureBuilder<bool>(
          future: userService.isLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final bool isLoggedIn = snapshot.data ?? false;
            debugPrint(isLoggedIn.toString());
            if (isLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (Patient patient in patientList)
                // Text(
                // patient.fullName,
                ProfileBox(name: patient.fullName, id: patient.userId, picture: patient.avatarImage),
                // const ProfileBox(),
                // const ProfileBox(),
                if (!isLoggedIn) SignUpUserButton(screenSize: screenSize),
                if (!isLoggedIn) ConfirmUserButton(screenSize: screenSize),
                if (!isLoggedIn) LoginUserButton(screenSize: screenSize),
                if (isLoggedIn)
                  LogoutUserButton(
                      userService: userService, screenSize: screenSize),
              ],
            );
            } else {
             return const CircularProgressIndicator();
            }
          },
        ),], 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPatientScreen(),
            ));
        },
        elevation: 5,
        hoverElevation: 25,
        splashColor: Colors.purple,
        backgroundColor: Colors.deepPurple,
        heroTag: 'uniqueTag',
        child: const Icon(Icons.add),
        
        
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
