import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  ServiceApp serviceApp;
  HomeController({
    required this.serviceApp,
  });

  TextEditingController dateEC = TextEditingController();
  TextEditingController nameEC = TextEditingController();

  RxList listPatient = [].obs;

  Rx<bool> statusIcon = true.obs;

  void isPresent() {
    statusIcon.value = !statusIcon.value;
  }

  @override
  void onInit() {
    dayNow();
    super.onInit();
  }

  Future<void> dayNow() async {
    DateTime? dataNow = DateTime.now();
    String dataString = DateFormat('dd/MM/yyyy').format(dataNow);
    try {
      listPatient.value = await serviceApp.selectDay(dataString);
      dateEC.text = dataString;
    } on DeadLineExceededServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('O prazo da operação expirou! Tente novamente')));
    } on CancelledServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('A operação foi cancelada! Tente novamente')));
    } on InvalidArgumentServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Dados inválido.! Tente novamente')));
    } on UnknowServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Erro desconhecido! Tente novamente')));
    } on GenericServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar! Tente novamente')));
    }
  }

  Future choiceDay() async {
    DateTime? data = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2025));

    if (data != null) {
      String showdata = DateFormat('dd/MM/yyyy').format(data);

      try {
        listPatient.value = await serviceApp.selectDay(showdata);
        dateEC.text = showdata;
      } on DeadLineExceededServiceError {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('O prazo da operação expirou! Tente novamente')));
      } on CancelledServiceError {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('A operação foi cancelada! Tente novamente')));
      } on InvalidArgumentServiceError {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Dados inválido.! Tente novamente')));
      } on UnknowServiceError {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Erro desconhecido! Tente novamente')));
      } on GenericServiceError {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Erro ao buscar dados! Tente novamente')));
      }
    } else {
      return null;
    }
  }

  Future<void> deleteConsult(String id) async {
    try {
      await serviceApp.deleteConsult(id);
    } on GenericServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Erro ao deletar dados! Tente novamente')));
    }
  }

  Future<void> updateFinalized(String id, bool isFinalized) async {
    try {
      await serviceApp.updateFinalized(id, isFinalized);
    } on GenericServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Erro ao atualizar dados! Tente novamente')));
    }
  }

  Future<void> updatePresent(String id, bool isPresent) async {
    try {
      serviceApp.updatePresent(id, isPresent);
    } on GenericServiceError {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Erro ao atualizar dados! Tente novamente')));
    }
  }
}
