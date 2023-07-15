import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:floor/floor.dart';

@dao
abstract class AlcoolDAO {
  @Query('SELECT * FROM Alcool')
  Future<List<Alcool>> findAllAlcool();

  @insert
  Future<void> insertAlcool(Alcool newAlcool);

  @delete
  Future<void> deleteAlcool(Alcool aAlcool);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAlcool(Alcool newAlcool);
}
