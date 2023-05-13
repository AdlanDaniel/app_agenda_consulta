import 'package:app_agenda_consulta/core/rest_client/firebase_client.dart';
import 'package:app_agenda_consulta/features/repository/repository.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:get/get.dart';

import '../../features/home/controller/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RepositoryImpl(database: FirebaseClient.database()));
    Get.put(ServiceApp(repository: Get.find<RepositoryImpl>()));
    Get.lazyPut<HomeController>(
        () => HomeController(serviceApp: Get.find<ServiceApp>()));
  }
}
