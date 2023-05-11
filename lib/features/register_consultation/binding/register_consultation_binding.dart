import 'package:app_agenda_consulta/features/register_consultation/controller/register_consultation_controller.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:get/get.dart';

class RegisterConsultationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterConsultationController>(() =>
        RegisterConsultationController(serviceApp: Get.find<ServiceApp>()));
  }
}
