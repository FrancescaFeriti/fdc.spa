import 'package:flow1_prova/database/database.dart';
import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:flow1_prova/database/entities/Datahealth.dart';
import 'package:flow1_prova/database/entities/Steps.dart';
import 'package:flow1_prova/database/entities/P_access.dart';
import 'package:flow1_prova/database/entities/Resthealth.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  final AppDatabase database;
  DatabaseRepository({required this.database});



  Future<List<P_access>> findAllP_access() async {
    final results = await database.p_accessDao.findAllP_access();
    return results;
  }

  Future<List<Alcool>> findAllAlcool() async {
    final results = await database.alcoolDao.findAllAlcool();
    return results;
  }

  Future<List<Datahealth>> findAllDatahealth() async {
    final results = await database.datahealthDao.findAllDatahealth();
    return results;
  }

  Future<List<Steps>> findAllSteps() async {
    final results = await database.stepsDao.findAllSteps();
    return results;
  }

  Future<List<Resthealth>> findAllResthealth() async {
    final results = await database.resthealthDao.findAllResthealth();
    return results;
  }

  Future<void> insertAlcool(Alcool alcool) async {
    await database.alcoolDao.insertAlcool(alcool);
    notifyListeners();
  }

  Future<void> insertP_access(P_access pAccess) async {
    await database.p_accessDao.insertP_access(pAccess);
    notifyListeners();
  }

  Future<void> insertDatahealth(Datahealth datahealth) async {
    await database.datahealthDao.insertDatahealth(datahealth);
    notifyListeners();
  }

  Future<void> insertResthealth(Resthealth resthealth) async {
    await database.resthealthDao.insertResthealth(resthealth);
    notifyListeners();
  }

  Future<void> insertSteps(Steps steps) async {
    await database.stepsDao.insertSteps(steps);
    notifyListeners();
  }


  Future<void> removeAlcool(Alcool alcool) async {
    await database.alcoolDao.deleteAlcool(alcool);
    notifyListeners();
  }

  Future<void> removeP_access(P_access pAccess) async {
    await database.p_accessDao.deleteP_access(pAccess);
    notifyListeners();
  }

  Future<void> removeDatahealth(Datahealth datahealth) async {
    await database.datahealthDao.deleteDatahealth(datahealth);
    notifyListeners();
  }

  Future<void> removeResthealth(Resthealth resthealth) async {
    await database.resthealthDao.deleteResthealth(resthealth);
    notifyListeners();
  }

  Future<void> removeSteps(Steps steps) async {
    await database.stepsDao.deleteSteps(steps);
    notifyListeners();
  }


  Future<void> updateAlcool(Alcool alcoolNew) async {
    await database.alcoolDao.updateAlcool(alcoolNew);
    notifyListeners();
  }
}
