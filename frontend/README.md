# Frontend

## Pre-requisites

### Flutter

Ensure that Flutter is installed on your system. You can download and install Flutter from
this [link](https://docs.flutter.dev/get-started/install). Install the
Flutter extension from [here](https://docs.flutter.dev/tools/vs-code) if you're using Visual Studio Code. A quick way to
confirm a successful installation is by
running the `flutter doctor` command and following the instructions. For additional help with Flutter, consider checking
the official documentation [here](https://docs.flutter.dev/).

### Android Studio

If you own an Android device, switch to developer mode and enable USB debugging. If you don't have a physical device,
Android Studio can be used to create an emulator for testing our application.

You can download and install Android Studio from this [link](https://developer.android.com/studio). You can create a new
device through Android Studio with any
screen size. Choose any images with an API level above 22 regarding the system image. We recommend using UpsideDownCake.
The official documentation is available [here](https://developer.android.com/studio/intro) if you need further
assistance with Android Studio.

### The secrets.dart file

Due to security reasons, the secrets.dart file is not publicly accessible. If you require access to this file, kindly
contact us. It should be placed under frontend/lib if you have obtained it. The following fields are contained in the
secrets.dart file:

```agsl
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

const cognitoUserPoolId = 'XXXXXXXXXXXXXXXXXXXXXXXXXX
const cognitoClientId = 'XXXXXXXXXXXXXXXXXXXXXXXXXX';
const cognitoIdentityPoolId ='XXXXXXXXXXXXXXXXXXXXXXXXXX';
const apiEndpoint ='XXXXXXXXXXXXXXXXXXXXXXXXXX';
const apiKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXX';
const mapboxSecretAccessToken ='XXXXXXXXXXXXXXXXXXXXXXXXXX';

final userPool = CognitoUserPool(cognitoUserPoolId, cognitoClientId);
```

## Running the application

To launch the application, run `flutter pub get` to install all dependencies, then `flutter run` to start the
application.
Make sure to select the correct Android device before running the application.

## Usage Examples

## Location of the APK file for deployment

## Future Plans

## Acknowledgements
