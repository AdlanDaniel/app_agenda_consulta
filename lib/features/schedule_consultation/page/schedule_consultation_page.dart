import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/core/ui/design/size.dart';
import 'package:app_agenda_consulta/core/ui/resources/messages.dart';
import 'package:app_agenda_consulta/core/ui/widgets/custom_button.dart';
import 'package:app_agenda_consulta/core/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_agenda_consulta/features/schedule_consultation/controller/schedule_consultation_controller.dart';
import 'package:validatorless/validatorless.dart';

class ScheduleConsultationPage extends StatefulWidget {
  const ScheduleConsultationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleConsultationPage> createState() =>
      _ScheduleConsultationPageState();
}

class _ScheduleConsultationPageState extends State<ScheduleConsultationPage> {
  final controller = Get.find<ScheduleConsultationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Message.titleRegister),
        backgroundColor: CustomColors.greenMedium,
      ),
      body: Form(
        key: controller.keyForm,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(CustomSize.sizeSM),
            child: Column(children: [
              CustomTextFormField(
                controller: controller.nameEC,
                labelText: Message.name,
                validator: Validatorless.required(Message.requiredField),
              ),
              const SizedBox(height: CustomSize.sizeXXL),
              CustomTextFormField(
                controller: controller.doctorEC,
                labelText: Message.doctor,
                validator: Validatorless.required(Message.requiredField),
              ),
              const SizedBox(height: CustomSize.sizeXXL),
              CustomTextFormField(
                  labelText: Message.date,
                  controller: controller.dateEC,
                  validator: Validatorless.required(Message.requiredField),
                  readonly: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.setData();
                    },
                    icon: const Icon(
                      Icons.edit_calendar,
                      color: CustomColors.greenMedium,
                    ),
                  )),
              const SizedBox(height: CustomSize.sizeXXXXL),
              Obx(() {
                return controller.status.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: CustomSize.sizeXXXXL,
                        child: CustomButton(
                            onPressed: () async {
                              if (controller.keyForm.currentState?.validate() ??
                                  false) {
                                controller.status.value = true;
                                controller.getPatientId();
                                await controller.scheduleConsult();
                              }
                            },
                            text: Message.define),
                      );
              })
            ]),
          ),
        ),
      ),
    );
  }
}
