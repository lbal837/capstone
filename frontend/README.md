# Frontend

## Pre-requisites

### Flutter

Install Flutter [here](https://docs.flutter.dev/get-started/install), if you are using Visual Studio Code then install
the extension [here](https://docs.flutter.dev/tools/vs-code). One easy way to know if everything is installed correctly
is by running `flutter doctor` and following the instructions there. If you need any assistance with Flutter, you can
read the documentation [here](https://docs.flutter.dev/).

### Android Studio

If you have a physical android device, simply enable developer mode and USB debugging. If you do not have a physical
device, utilise android studio to create an emulator to test our application on.

Install Android Studio [here](https://developer.android.com/studio). Create a new device through Android Studio, any
screen would suffice. When it comes to the system image, any images above an API level of 22 should suffice, however we
recommend using `UpsideDownCake`. If you need any assistance with Android Studio, you can read the
documentation [here](https://developer.android.com/studio/intro).

### The secrets.dart file

For security purposes, the `secrets.dart` file has been hidden away. If you need access to this file, please contact us.
If you have received it, place it under `frontend/lib` Below are the fields which the `secrets.dart` file will contain:

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

Run the application with `flutter pub get` to install all the dependencies, followed by `flutter run` to run the
application. Ensure you have selected the appropriate android device to run the application on.


## Usage Examples

## Location of the APK file for deployment

## Future Plans

## Acknowledgements
