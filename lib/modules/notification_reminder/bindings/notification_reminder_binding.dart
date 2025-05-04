import 'package:get/get.dart';
import '../controllers/notification_reminder_controller.dart';

class NotificationReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationReminderController>(
      () => NotificationReminderController(),
    );
  }
}
