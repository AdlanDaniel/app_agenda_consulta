// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_agenda_consulta/features/repository/repository.dart';
import 'package:app_agenda_consulta/models/patient_model.dart';

class ServiceApp {
  Repository repository;
  ServiceApp({
    required this.repository,
  });

  Future<void> register(PatientModel patient) async {
    try {
      await repository.register(patient);
    } on DeadLineExceededRepositoryError {
      throw DeadLineExceededServiceError();
    } on CancelledRepositoryError {
      throw CancelledServiceError();
    } on InvalidArgumentRepositoryError {
      throw InvalidArgumentServiceError();
    } on UnknowRepositoryError {
      throw UnknowServiceError();
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }

  String getPatientId() {
    try {
      return repository.getPatientId();
    } on DeadLineExceededRepositoryError {
      throw DeadLineExceededServiceError();
    } on CancelledRepositoryError {
      throw CancelledServiceError();
    } on InvalidArgumentRepositoryError {
      throw InvalidArgumentServiceError();
    } on UnknowRepositoryError {
      throw UnknowServiceError();
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }

  Future<List<PatientModel>> getInfo(String date) async {
    try {
      return await repository.getInfo(date);
    } on DeadLineExceededRepositoryError {
      throw DeadLineExceededServiceError();
    } on CancelledRepositoryError {
      throw CancelledServiceError();
    } on InvalidArgumentRepositoryError {
      throw InvalidArgumentServiceError();
    } on UnknowRepositoryError {
      throw UnknowServiceError();
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }

  Future<List<PatientModel>> selectDay(String date) async {
    try {
      return await repository.selectDay(date);
    } on DeadLineExceededRepositoryError {
      throw DeadLineExceededServiceError();
    } on CancelledRepositoryError {
      throw CancelledServiceError();
    } on InvalidArgumentRepositoryError {
      throw InvalidArgumentServiceError();
    } on UnknowRepositoryError {
      throw UnknowServiceError();
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }

  Future<void> deleteConsult(String id) async {
    try {
      await repository.deleteConsult(id);
    } on DeleteClientsRepositoryError {
      throw GenericServiceError();
    }
  }

  Future<void> updateFinalized(String id, bool isFinalized) async {
    try {
      await repository.updateFinalized(id, isFinalized);
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }

  Future<void> updatePresent(String id, bool isPresent) async {
    try {
      repository.updatePresent(id, isPresent);
    } on GenericRepositoryError {
      throw GenericServiceError();
    }
  }
}

class DeadLineExceededServiceError implements Exception {}

class CancelledServiceError implements Exception {}

class InvalidArgumentServiceError implements Exception {}

class UnknowServiceError implements Exception {}

class GenericServiceError implements Exception {}

class DeleteClientsServiceError implements Exception {}
