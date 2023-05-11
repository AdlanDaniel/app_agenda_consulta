import 'package:app_agenda_consulta/features/home/controller/home_controller.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(serviceApp: Get.find<ServiceApp>()));
  }
}
