import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_icon.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';
import 'package:frontend/ui/main/main_screen.dart';

class HomeScreenState extends State<HomeScreen> {
  final userService = UserService(userPool);
  final userRepository = UserDefaultRepository();
  List<Patient> patientList = [];
  bool isLoaded = false;

  late Future<bool> isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    isLoggedInFuture = userService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<bool>(
        future: isLoggedInFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: SpinKitPumpingHeart(color: Colors.purple)),
              ],
            );
          }
          final bool isLoggedIn = snapshot.data ?? false;

          if (isLoggedIn) {
            return MainScreen(
              isLoaded: isLoaded,
              userService: userService,
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: const HomeIcon(imagePath: 'assets/images/icon.png'),
                ),
                const Text(
                  'LifeSavers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist',
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 5),
                LoginUserButton(screenSize: screenSize),
                const Spacer(flex: 3),
                const SizedBox(
                  height: 40,
                  child: Text('New User? Sign up below'),
                ),
                SignUpUserButton(screenSize: screenSize),
                ConfirmUserButton(screenSize: screenSize),
              ],
            );
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}
