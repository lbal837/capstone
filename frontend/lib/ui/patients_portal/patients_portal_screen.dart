import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/patients_portal/widgets/patients_portal_profile_box.dart';
import 'package:intl/intl.dart';

class PatientsPortalScreen extends StatefulWidget {
  final UserRepository userRepository = UserDefaultRepository();
  final UserService userService;
  final bool isLoaded;

  PatientsPortalScreen({
    Key? key,
    required this.userService,
    required this.isLoaded,
  }) : super(key: key);

  @override
  PatientPortalScreenState createState() => PatientPortalScreenState();
}

class PatientPortalScreenState extends State<PatientsPortalScreen> {
  List<Patient> patientList = [];
  bool isLoaded = false;
  Future? getDataFuture;

  @override
  void initState() {
    super.initState();
    getDataFuture = getData();
  }

  Future<void> getData() async {
    final user = await widget.userService.getCurrentUser();
    patientList = await widget.userRepository.fetchUserPatients(user!.email!);
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  bool isWithinOneMinute(String dateTimeString) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final dateTime = format.parseUtc(dateTimeString);
    final now = DateTime.now().toUtc().add(const Duration(hours: 12));
    final difference = now.difference(dateTime);
    return difference.inSeconds.abs() < 60;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getDataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitPumpingHeart(color: Colors.purple),
          );
        } else {
          return Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: ListView(
                    children: <Widget>[
                      for (Patient patient in patientList)
                        ProfileBox(
                          name: patient.fullName,
                          id: patient.userId,
                          picture: patient.avatarImage,
                          isConnected: isWithinOneMinute(patient.dateTime),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDataFuture = getData();
  }
}
