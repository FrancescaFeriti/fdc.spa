import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:flow1_prova/screens/homePage.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';
import 'package:flow1_prova/screens/addAlcool.dart';
import 'package:provider/provider.dart';

class AlcoolPage extends StatefulWidget {
  const AlcoolPage({Key? key}) : super(key: key);
  static const routename = 'AlcoolPage';

  @override
  _stateAlcoolPage createState() => _stateAlcoolPage();
}

class _stateAlcoolPage extends State<AlcoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
        title: const Text(
          'Alcohol Page',
          style: TextStyle(fontFamily: 'MarcellusSC', fontSize: 30),
        ),
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(
          builder: (context, dbr, child) {
            return FutureBuilder<List<Alcool>>(
              initialData: const [],
              future: dbr.findAllAlcool(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return data.isEmpty
                      ? const Text('The Alcohol List is currently empty for today')
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, alcoolIndex) {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: _chooseIcon(data[alcoolIndex]),
                                trailing: const Icon(
                                  MdiIcons.noteEdit,
                                  color: Color.fromRGBO(213, 181, 229, 0.929),
                                ),
                                title: Text(data[alcoolIndex].type),
                                subtitle: Text(
                                    'Volume : ${data[alcoolIndex].volume}, Percentage : ${data[alcoolIndex].percentage}, Hour: ${data[alcoolIndex].hour}'),
                                //qui aprire cosa che chiede se si vuole modificare o rimuovere
                                onTap: () => _openUpdateDialog(context, data[alcoolIndex]),
                              ),
                            );
                          },
                        );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () => _toAddAlcool(context, null),
            backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
            child: const Icon(Icons.plus_one_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _backHome(context),
            backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
            child: const Icon(Icons.home_filled),
          ),
        ],
      ),
    );
  }

  void _openUpdateDialog(BuildContext context, Alcool alcoolin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove or Update Alcool Intake?', 
        style: TextStyle(fontFamily: 'MarcellusSC',color: Color.fromARGB(255, 50, 3, 59)),),
        content: SizedBox(
          height: 130,
          child: Center(child: Column(
          children: [
              Text(
                'You have already inserted this Alcool Intake.\nDo you desire to modify or remove it?',
              ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(213, 181, 229, 0.929)),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(213, 181, 229, 0.929)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _toAddAlcool(context, alcoolin);
                },
                child: const Text('Update'),
              ),])
          ],
        ),
      )))
    );
  }

  /*
  void _updateInsert(BuildContext context, Alcool alcoolin) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AddAlcool(init_alcool: alcoolin)));
  }
  */

  void _backHome(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _toAddAlcool(BuildContext context, Alcool? newAlcool) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAlcool(init_alcool: newAlcool)),
    );
  }

  Icon _chooseIcon(Alcool alcool) {
    if (alcool.type == 'Beer') {
      return const Icon(MdiIcons.glassMug, color: Color.fromARGB(255, 50, 3, 59));
    } else if (alcool.type == 'Wine') {
      return const Icon(
        MdiIcons.glassWine,
        color: Color.fromARGB(255, 50, 3, 59),
      );
    } else if (alcool.type == 'Cocktail') {
      return const Icon(
        MdiIcons.glassCocktail,
        color: Color.fromARGB(255, 50, 3, 59),
      );
    } else {
      return const Icon(
        MdiIcons.beer,
        color: Color.fromARGB(255, 50, 3, 59),
      );
    }
  }
}

//Voglio che questa pagina mostri tutti i consumi alcolici di quel giorno  (magari anche usare icone diverse a seconda del tipo di alcolico selezionato
// con opzioni tipo: -Vino, -Birra, -Superalcolico, -Altro) --> + tiene conto della somma (in grammi) totale di quel giorno
//Tasto + per aggiungere ... magari apre un pop up in cui inserire e quando si preme submit si torna, poi c'è anche la posisbilità di annullare

//Per la prima parte copiare praticamente l'esempio meal visto a lezione (lab 11)
