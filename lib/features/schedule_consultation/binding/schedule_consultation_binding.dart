import 'package:app_agenda_consulta/features/schedule_consultation/controller/schedule_consultation_controller.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:get/get.dart';

class ScheduleConsultationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleConsultationController>(() =>
        ScheduleConsultationController(serviceApp: Get.find<ServiceApp>()));
  }
}
