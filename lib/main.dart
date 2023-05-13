import 'package:app_agenda_consulta/core/binding/initial_binding.dart';
import 'package:app_agenda_consulta/features/home/page/home_page.dart';
import 'package:app_agenda_consulta/features/schedule_consultation/binding/schedule_consultation_binding.dart';
import 'package:app_agenda_consulta/features/schedule_consultation/page/schedule_consultation_page.dart';
import 'package:app_agenda_consulta/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      home: const HomePage(),
      getPages: [
        GetPage(
          name: AppRoutes.homePage,
          page: () => const HomePage(),
        ),
        GetPage(
            name: AppRoutes.registerConsultationPage,
            page: () => const ScheduleConsultationPage(),
            binding: ScheduleConsultationBinding())
      ],
    );
  }
}
