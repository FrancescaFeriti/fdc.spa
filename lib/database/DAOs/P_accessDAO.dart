import 'package:flow1_prova/database/entities/P_access.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

//si usa il decorator dao e si crea la classe astratta con dentro tutte le possibili operazioni che possono essere eseguite sulla tabella todo
@dao
abstract class P_accessDAO {

  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM P_access') //si usa tipo SQL
  Future<List<P_access>> findAllP_access();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertP_access(P_access newaccess);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete //alternativa a @QUERY ('DELETE * FROM Todo')
  Future<void> deleteP_access(P_access pAccess); //floor, grazie alla chiave primaria, riesce a capire esattamente cosa deve eliminare

  //Query #4: EXTRACT_LAST_ID --> This extracts the id of the last user 
  /*
  @Query('SELECT MAX(id) FROM P_access')
  Future<int?> extract_last_access();
  */

}//P_accessDAO

//Si userà il DAO per aver accesso ai dati nel nostro codice