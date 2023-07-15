
import 'package:flow1_prova/database/entities/P_access.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'Steps', primaryKeys: ['id','day'], foreignKeys: [ForeignKey(childColumns:['id'], parentColumns: ['id'], entity: P_access,)])
class Steps {
  final int? id;
  final String day;

  final int num_steps;

  Steps(this.id, this.day, this.num_steps);

}