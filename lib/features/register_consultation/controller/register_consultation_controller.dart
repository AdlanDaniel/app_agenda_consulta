import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_agenda_consulta/features/service/service_app.dart';
import 'package:intl/intl.dart';

enum Status { initial, loading, suceful, error }

class RegisterConsultationController extends GetxController {
  ServiceApp serviceApp;
  RegisterConsultationController({
    required this.serviceApp,
  });

  @override
  void onClose() {
    nameEC.dispose();
    doctorEC.dispose();
    dateEC.dispose();
    idEC.dispose();
    super.onClose();
  }

  final nameEC = TextEditingController();
  final doctorEC = TextEditingController();
  final dateEC = TextEditingController();
  final idEC = TextEditingController();

  RxBool status = false.obs;

  List<PatientModel> listPatient = [];

  void clearFields() {
    nameEC.clear();
    doctorEC.clear();
    dateEC.clear();
    idEC.clear();
  }

  Future<void> register() async {
    PatientModel patient = PatientModel();
    patient.name = nameEC.text;
    patient.doctor = doctorEC.text;
    patient.id = idEC.text;
    patient.date = dateEC.text;
    try {
      await serviceApp.register(patient);
      clearFields();
      status.value = false;

      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Agendamento realizado com sucesso'),
        duration: Duration(seconds: 4),
        backgroundColor: CustomColors.greenMedium,
      ));
    } on DeadLineExceededServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('O prazo da operação expirou! Tente novamente'),
          duration: Duration(seconds: 4),
          backgroundColor: CustomColors.orangeMedium));
    } on CancelledServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('A operação foi cancelada! Tente novamente'),
          backgroundColor: CustomColors.orangeMedium));
    } on InvalidArgumentServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Dados inválido.! Tente novamente'),
          backgroundColor: CustomColors.orangeMedium));
    } on UnknowServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Erro desconhecido! Tente novamente'),
          backgroundColor: CustomColors.orangeMedium));
    } on GenericServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Erro ao cadastrar! Tente novamente'),
          backgroundColor: CustomColors.orangeMedium));
    }
  }

  Future setData() async {
    DateTime? data = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));

    if (data != null) {
      dateEC.text = DateFormat('dd/MM/yyyy').format(data);
    }
  }

  void getPatientId() {
    try {
      idEC.text = serviceApp.getPatientId();
    } on GenericServiceError {
      status.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Erro ao cadastrar! Tente novamente')));
    }
  }
}
