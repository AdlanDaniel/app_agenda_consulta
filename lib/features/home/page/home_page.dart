import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/core/ui/design/size.dart';
import 'package:app_agenda_consulta/core/ui/resorces/messages.dart';
import 'package:app_agenda_consulta/core/ui/widgets/custom_text_form_field.dart';
import 'package:app_agenda_consulta/features/home/controller/home_controller.dart';
import 'package:app_agenda_consulta/routes/routes.dart';
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
                  Get.toNamed(Routes.registerConsultationPage)
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
                    itemCount: controller.listPatient.length,
                    onReorder: ((oldIndex, newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      final patient = controller.listPatient.removeAt(oldIndex);
                      controller.listPatient.insert(newIndex, patient);
                    }),
                    itemBuilder: (context, index) {
                      // final patientIndexGet =
                      //     Rx<PatientModel>(controller.listPatient[index]);

                      final patientIndex = controller.listPatient[index];
                      return Column(
                        key: ValueKey(patientIndex.name),
                        children: [
                          Card(
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  controller.deleteConsult(patientIndex.id);
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
                              key: Key(patientIndex.name),
                              child: Obx(
                                () => ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      top: CustomSize.sizeS,
                                      bottom: CustomSize.sizeXS),
                                  trailing: Checkbox(
                                      value: patientIndex.finalized,
                                      onChanged: (value) async {
                                        setState(() {
                                          patientIndex.finalized = value;
                                        });

                                        await controller.updateFinalized(
                                            patientIndex.id,
                                            patientIndex.finalized);
                                      }),
                                  leading: IconButton(
                                    icon: patientIndex.present
                                        ? const Icon(Icons.person,
                                            size: CustomSize.sizeXXXXL,
                                            color: CustomColors.greenMedium)
                                        : const Icon(Icons.person,
                                            size: CustomSize.sizeXXXXL,
                                            color: CustomColors.orangeMedium),
                                    onPressed: () async {
                                      setState(() {
                                        patientIndex.present =
                                            !patientIndex.present;
                                      });
                                      await controller.updatePresent(
                                          patientIndex.id,
                                          patientIndex.present);
                                    },
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        patientIndex.name!,
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
                                        'Dr(a) ${controller.listPatient[index].doctor}',
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
