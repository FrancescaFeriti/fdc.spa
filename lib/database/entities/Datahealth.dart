import 'package:floor/floor.dart';
import 'package:flow1_prova/database/entities/Resthealth.dart';

@Entity(tableName:'Datahealth', primaryKeys: ['id','day','hour'],foreignKeys: [ForeignKey(childColumns: ['id','day'], parentColumns: ['id','date'], entity: Resthealth)])
class Datahealth{

  final int? id;
  final String day;
  final int hour;

  final double value;

  Datahealth(this.id, this.day,this.hour, this.value);
  
}