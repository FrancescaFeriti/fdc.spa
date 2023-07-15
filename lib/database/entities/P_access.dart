import 'package:floor/floor.dart';

@Entity(tableName: 'P_access')
class P_access{
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? name;
  final String? surname;
  final String? sex;
  final String? birth;

  P_access(this.id, this.name, this.surname, this.sex, this.birth);

}