import 'package:app_agenda_consulta/models/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository {
  String getPatientId();
  Future<void> scheduleConsult(PatientModel patient);
  Future<List<PatientModel>> getPatientInfo(String date);
  Future<List<PatientModel>> selectDay(String date);
  Future<void> deleteConsult(String id);
  Future<void> changeStatusPatient(String id, bool isPresent);
  Future<void> changeStatusConsult(String id, bool isFinalized);
}

class RepositoryImpl implements Repository {
  FirebaseFirestore database;
  RepositoryImpl({
    required this.database,
  });

  @override
  Future<void> scheduleConsult(PatientModel patient) async {
    try {
      await database
          .collection('pacientes')
          .doc(patient.id)
          .set(patient.toMap());
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'deadline-exceeded':
          throw DeadLineExceededRepositoryError();
        case 'canceleed':
          throw CancelledRepositoryError();
        case 'invalid-argument-error':
          throw InvalidArgumentRepositoryError();
        case 'unknow-error':
          throw UnknowRepositoryError();

        default:
          throw GenericRepositoryError();
      }
    } catch (_) {
      throw GenericRepositoryError();
    }
  }

  @override
  String getPatientId() {
    try {
      return database.collection('pacientes').doc().id;
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'deadline-exceeded':
          throw DeadLineExceededRepositoryError();
        case 'canceleed':
          throw CancelledRepositoryError();
        case 'invalid-argument-error':
          throw InvalidArgumentRepositoryError();
        case 'unknow-error':
          throw UnknowRepositoryError();

        default:
          throw GenericRepositoryError();
      }
    } catch (_) {
      throw GenericRepositoryError();
    }
  }

  @override
  Future<List<PatientModel>> getPatientInfo(String date) async {
    List<PatientModel> patients = [];
    try {
      QuerySnapshot querySnapshot = await database
          .collection('pacientes')
          .where('date', isEqualTo: date)
          .get();
      List<QueryDocumentSnapshot> listQuery = querySnapshot.docs;
      listQuery.forEach((element) {
        Map<String, dynamic> patientMap =
            element.data() as Map<String, dynamic>;
        patients.add(PatientModel.fromMap(patientMap));
      });
      return patients;
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'deadline-exceeded':
          throw DeadLineExceededRepositoryError();
        case 'canceleed':
          throw CancelledRepositoryError();
        case 'invalid-argument-error':
          throw InvalidArgumentRepositoryError();
        case 'unknow-error':
          throw UnknowRepositoryError();

        default:
          throw GenericRepositoryError();
      }
    } catch (_) {
      throw GenericRepositoryError();
    }
  }

  @override
  Future<List<PatientModel>> selectDay(String date) async {
    List<PatientModel> patients = [];
    try {
      QuerySnapshot querySnapshot = await database
          .collection('pacientes')
          .where('date', isEqualTo: date)
          .get();
      List<QueryDocumentSnapshot> listQuery = querySnapshot.docs;
      listQuery.forEach((element) {
        Map<String, dynamic> patientMap =
            element.data() as Map<String, dynamic>;
        patients.add(PatientModel.fromMap(patientMap));
      });
      return patients;
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'deadline-exceeded':
          throw DeadLineExceededRepositoryError();
        case 'canceleed':
          throw CancelledRepositoryError();
        case 'invalid-argument-error':
          throw InvalidArgumentRepositoryError();
        case 'unknow-error':
          throw UnknowRepositoryError();

        default:
          throw GenericRepositoryError();
      }
    } catch (_) {
      throw GenericRepositoryError();
    }
  }

  @override
  Future<void> deleteConsult(String id) async {
    try {
      await database.collection('pacientes').doc(id).delete();
    } on Exception {
      throw DeleteClientsRepositoryError();
    }
  }

  @override
  Future<void> changeStatusConsult(String id, bool isFinalized) async {
    try {
      await database
          .collection('pacientes')
          .doc(id)
          .update({'finalized': isFinalized});
    } on Exception {
      throw GenericRepositoryError();
    }
  }

  @override
  Future<void> changeStatusPatient(String id, bool isPresent) async {
    try {
      await database
          .collection('pacientes')
          .doc(id)
          .update({'present': isPresent});
    } on Exception {
      throw GenericRepositoryError();
    }
  }
}

class DeadLineExceededRepositoryError implements Exception {}

class CancelledRepositoryError implements Exception {}

class InvalidArgumentRepositoryError implements Exception {}

class UnknowRepositoryError implements Exception {}

class GenericRepositoryError implements Exception {}

class DeleteClientsRepositoryError implements Exception {}
