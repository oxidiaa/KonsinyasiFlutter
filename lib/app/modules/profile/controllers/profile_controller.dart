import 'package:get/get.dart';

class ProfileController extends GetxController {
  final name = 'Anita Silvana'.obs;
  final email = 'anitasilvana25@gmail.com'.obs;

  void updateProfile({String? newName, String? newEmail}) {
    if (newName != null) name.value = newName;
    if (newEmail != null) email.value = newEmail;
  }

  void logout() {
    // TODO: Clear user session/preferences
    Get.offAllNamed('/login');
  }
}
