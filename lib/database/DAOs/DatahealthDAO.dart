import 'package:flow1_prova/database/entities/Datahealth.dart';
import 'package:floor/floor.dart';


@dao
abstract class DatahealthDAO {

  @Query('SELECT * FROM Datahealth ') 
  Future<List<Datahealth>> findAllDatahealth();

  @insert
  Future<void> insertDatahealth(Datahealth newdatahealth);

  @delete 
  Future<void> deleteDatahealth(Datahealth adatahealth); 

}