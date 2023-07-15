import 'package:flow1_prova/database/entities/Steps.dart';
import 'package:floor/floor.dart';


@dao
abstract class StepsDAO {

  @Query('SELECT * FROM Steps ') 
  Future<List<Steps>> findAllSteps();

  @insert
  Future<void> insertSteps(Steps newsteps);

  @delete 
  Future<void> deleteSteps(Steps step); 

}