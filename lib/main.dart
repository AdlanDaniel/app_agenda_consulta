import 'package:app_agenda_consulta/binding/initial_binding.dart';
import 'package:app_agenda_consulta/features/home/page/home_page.dart';
import 'package:app_agenda_consulta/features/register_consultation/binding/register_consultation_binding.dart';
import 'package:app_agenda_consulta/features/register_consultation/page/register_consultation_page.dart';
import 'package:app_agenda_consulta/routes/routes.dart';
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
          name: Routes.homePage,
          page: () => const HomePage(),
          // binding: HomeBinding(),
        ),
        GetPage(
            name: Routes.registerConsultationPage,
            page: () => const RegisterConsultationPage(),
            binding: RegisterConsultationBinding())
      ],
    );
  }
}
