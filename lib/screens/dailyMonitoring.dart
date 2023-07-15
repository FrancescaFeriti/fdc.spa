import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flow1_prova/screens/homePage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flow1_prova/utils/hr.dart';
import 'package:flow1_prova/algorithms/algorithms.dart';
import 'package:flow1_prova/database/database.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';
import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:flow1_prova/database/entities/Datahealth.dart';
import 'package:flow1_prova/database/entities/Resthealth.dart';
import 'package:flow1_prova/database/entities/Steps.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DailyMonitoring extends StatefulWidget {
  const DailyMonitoring({Key? key}) : super(key: key);
  static const routename = 'DailyMonitoring';

  @override
  _stateDailyMonitoring createState() => _stateDailyMonitoring();

}

class _stateDailyMonitoring extends State<DailyMonitoring> {

  final colorList = <Color>[
    Color.fromARGB(251, 245, 224, 87),
    Color.fromARGB(231, 121, 31, 110),
    Color.fromARGB(255, 14, 96, 16),
    Color.fromARGB(255, 78, 86, 240)
  ];

  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().subtract(const Duration(days: 1));
    String chosen_date = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    print(chosen_date);
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(135, 47, 183, .9),
        title: const Text('Daily Monitoring', style: TextStyle(fontFamily: 'MarcellusSC', fontSize: 30),),
      ),
      body: Consumer<DatabaseRepository> (
        builder: (context, dbr, child) {
          return SingleChildScrollView(
            child :Column (
            children: [
              FutureBuilder<List<Datahealth>> (
                future: _getHeartDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data.length == 0
                    ? Text("No Heart Rate Data avaible")
                    :
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Daily Heart Rate', textStyle: TextStyle(color: Color.fromARGB(255, 50, 3, 59), fontFamily: 'MarcellusSC', fontSize: 16)), 
                        legend:Legend(isVisible: false),
                        series: <LineSeries<hr, int>> [
                          LineSeries(
                            dataSource: _chardata(data), color: Color.fromARGB(255, 50, 3, 58),
                            //creare lista di hr dai dati del db
                            xValueMapper: (hr heart_rate, _) => heart_rate.hour,
                            yValueMapper: (hr heart_rate, _) => heart_rate.value,
                          )
                        ],
                    
                      );
                      
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List<Datahealth>> (
                future: _getHeartDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data.length == 0
                    ? Text("No Heart Rate Data avaible")
                    : Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.purple[100],
                          child: ListTile(
                            title: Text('Mean Heart Rate value:'),
                            subtitle: Text(
                                '${mean_hr(data).toStringAsFixed(1)}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 50, 3, 58))),
                            trailing: Icon(
                              MdiIcons.heartPulse,
                              color: Color.fromARGB(255, 50, 3, 58),
                            ),
                          ),
                        ));   
                            
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: _getRestHeartDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data == null
                    ? Text("No rest heart data available")
                      :Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.purple[100],
                          child: ListTile(
                            title: Text('Rest heart today:'),
                            subtitle: Text(
                                '$data',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 50, 3, 58))),
                            trailing: Icon(
                              MdiIcons.heartCircle,
                              color: Color.fromARGB(255, 50, 3, 58),
                            ),
                          ),
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),


              Text('Alcohol assumption',style: TextStyle( color: Color.fromARGB(255, 50, 3, 58), fontFamily: 'MarcellusSC',fontSize: 20),),
              FutureBuilder<List<Alcool>>(
                future: _getAlcoolDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data.length == 0
                    ? Text("No Alcohol Data available")
                    : PieChart(
                      
                        dataMap: _pieAlcool(data),
                        chartType: ChartType.disc,
                        baseChartColor: Colors.white,
                        colorList: colorList
                      );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
              FutureBuilder(
                future: _getAlcoolDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data.length == 0 
                    ? Text("No Alcool Data available")
                      :Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.purple[100],
                          child: ListTile(
                            title: Text('Total gram alcohol today:'),
                            subtitle: Text(
                                '${alcool_grams_sum(alcool_grams(data)).toStringAsFixed(1)}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 50, 3, 58))),
                            trailing: Icon(
                              MdiIcons.bottleWine,
                              color: Color.fromARGB(255, 50, 3, 58),
                            ),
                          ),
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
              FutureBuilder(
                future: _getStepDay(context, chosen_date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return data == null
                    ? Text("No Steps Data available")
                      :Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.purple[100],
                          child: ListTile(
                            title: Text('Total steps today:'),
                            subtitle: Text(
                                '$data',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 50, 3, 58))),
                            trailing: Icon(
                              MdiIcons.runFast,
                              color: Color.fromARGB(255, 50, 3, 58),
                            ),
                          ),
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
             // Row(
              //  children: [
                  FutureBuilder(
                    future: _getStepDay(context, chosen_date),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return data == null
                        ? Text("")
                        : Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                            title: Text('Step Evaluation'),
                            subtitle: _choseIconStep(data))
                            ),
                          );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
              FutureBuilder(
                    future: _getAlcoolDay(context, chosen_date),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return data == null
                        ? Text("No Alcohol Consumption Today")
                        : Container(
                          child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                            title: Text('Alcohol available'),
                            subtitle: _chooseIconAlcool(alcool_grams_sum(alcool_grams(data))))
                            ),
                          );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
                ],
              )
            //],
          //)
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(135, 47, 183, .9),
        child: const Icon(Icons.home_filled),
        onPressed: () => _backHome(context),
      ),
    );

  }

  Icon _choseIconStep(int passi) {
    if (passi > 10000) {
      return Icon(MdiIcons.emoticonHappyOutline, color: Colors.green,size: 40,);
    } else {
      return Icon(MdiIcons.emoticonSadOutline, color: Colors.red,size: 40,);
    }
  }

  Icon _chooseIconAlcool(double grammialcool){
    if (grammialcool == 0) {
      return Icon(MdiIcons.starOutline, color: Colors.green,size: 40);
    } else if ((grammialcool > 0) && (grammialcool < 20)){
     return Icon(MdiIcons.emoticonNeutralOutline, color: Colors.yellow,size: 40);
    } else {
      return Icon(MdiIcons.emoticonSadOutline, color: Colors.red,size: 40);
    }
  }


   void _backHome(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<List<Alcool>> _getAlcoolDay(BuildContext context, String day_chosen) async {
    List<Alcool> alcool_list_tot = await Provider.of<DatabaseRepository>(context, listen:false).findAllAlcool();
    int num_alcool = alcool_list_tot.length;
    List<Alcool> alcool_list = []; 

    for (int bev = 0; bev < num_alcool; bev++) {
      if (alcool_list_tot[bev].day == day_chosen) {
        alcool_list.add(alcool_list_tot[bev]);
      }
    }
    return alcool_list;
  }
  
  Future<int?> _getStepDay(BuildContext context, String chosen_day) async {
    List<Steps> steps_list_tot = await Provider.of<DatabaseRepository>(context, listen:false).findAllSteps();
    int numsteps = steps_list_tot.length; 
    int? result = null;

    for (int i = 0; i < numsteps; i++) {
      if (steps_list_tot[i].day == chosen_day) {
        result = steps_list_tot[i].num_steps;
      }
    }
    return result;
  }

  Future<List<Datahealth>> _getHeartDay(BuildContext context, String chosen_day) async {
    List<Datahealth> heart_list_tot = await Provider.of<DatabaseRepository>(context, listen:false).findAllDatahealth();
    int num_heart = heart_list_tot.length;
    List<Datahealth> heart_list = []; 

    for (int i = 0; i < num_heart; i++) {
      if (heart_list_tot[i].day == chosen_day) {
        heart_list.add(heart_list_tot[i]);
      }
    }
    return heart_list;
  }
  
  Future<double?> _getRestHeartDay(BuildContext context, String chosen_day) async {
    List<Resthealth> heart_list_tot = await Provider.of<DatabaseRepository>(context, listen:false).findAllResthealth();
    int num_heart = heart_list_tot.length;
    for (int i = 0; i < num_heart; i++) {
      if (heart_list_tot[i].date == chosen_day) {
        return heart_list_tot[i].restv;
      }
    }
    return null;
  }

  List<hr> _chardata(List<Datahealth> lista_hr) {
    List<hr> result = [];
    for (int el = 0; el < lista_hr.length; el++) {
      result.add(hr(lista_hr[el].hour, lista_hr[el].value));
    }
    return result;
  }

  Map<String, double> _pieAlcool(List<Alcool> alcool_lista) {
    List<String> key = ["Beer", "Wine", "Cocktail", "Other"];
    List<double> valori = alcool_grams(alcool_lista);
    //print(valori);
    Map<String, double> dataMap = {};
    for (int i = 0; i < 4; i++) {
      dataMap[key[i]] = valori[i];
    }
    //print(dataMap);
    return dataMap;
  }

}