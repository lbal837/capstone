import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([UserService])
@GenerateMocks([PatientRepository])
class Mocks {}

void main() {
  testWidgets('Passing test', (WidgetTester tester) async {
    const pass = true;
    expect(pass, true);
  });
}
