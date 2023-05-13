import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/core/ui/design/size.dart';
import 'package:app_agenda_consulta/core/ui/resources/messages.dart';
import 'package:app_agenda_consulta/core/ui/widgets/custom_text_form_field.dart';
import 'package:app_agenda_consulta/features/home/controller/home_controller.dart';
import 'package:app_agenda_consulta/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.greenMedium,
          title: const Text(Message.titleHome),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.registerConsultationPage)
                      ?.then((value) => controller.dayNow());
                },
                icon: const Icon(
                  Icons.add,
                  color: CustomColors.white,
                  size: CustomSize.sizeXXL,
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: CustomTextFormField(
                  textAlign: TextAlign.center,
                  readonly: true,
                  controller: controller.dateEC,
                  labelText: '',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.edit_calendar,
                      color: CustomColors.greenMedium,
                    ),
                    onPressed: () {
                      controller.choiceDay();
                    },
                  ),
                )),
            Obx(
              () => Expanded(
                flex: 16,
                child: ReorderableListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.patients.length,
                    onReorder: ((oldIndex, newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      final patient = controller.patients.removeAt(oldIndex);
                      controller.patients.insert(newIndex, patient);
                    }),
                    itemBuilder: (context, index) {
                      final patient = controller.patients[index];

                      return Column(
                        key: Key(patient.id),
                        children: [
                          Card(
                            child: Dismissible(
                              key: Key(patient.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  controller.removePatient(index);
                                  controller.deleteConsult(patient.id);
                                }
                              },
                              background: Container(
                                  color: CustomColors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(Icons.delete,
                                          color: CustomColors.white)
                                    ],
                                  )),
                              child: Obx(
                                () => ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      top: CustomSize.sizeS,
                                      bottom: CustomSize.sizeXS),
                                  trailing: Checkbox(
                                      value: patient.finalized,
                                      onChanged: (value) async {
                                        setState(() {
                                          patient.finalized = value;
                                        });

                                        await controller.changeStatusConsult(
                                            patient.id, patient.finalized);
                                      }),
                                  leading: IconButton(
                                    icon: patient.present
                                        ? const Icon(Icons.person,
                                            size: CustomSize.sizeXXXXL,
                                            color: CustomColors.greenMedium)
                                        : const Icon(Icons.person,
                                            size: CustomSize.sizeXXXXL,
                                            color: CustomColors.orangeMedium),
                                    onPressed: () async {
                                      setState(() {
                                        patient.present = !patient.present;
                                      });
                                      await controller.changeStatusPatient(
                                          patient.id, patient.present);
                                    },
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        patient.name!,
                                        style: const TextStyle(
                                            fontSize: CustomSize.sizeXL,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: CustomSize.sizeS),
                                      Text(
                                        'Dr(a) ${controller.patients[index].doctor}',
                                        style: const TextStyle(
                                            fontSize: CustomSize.sizeL,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
