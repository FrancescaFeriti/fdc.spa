import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flow1_prova/database/entities/P_access.dart';
import 'package:flow1_prova/screens/homePage.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const routename = 'SettingPage';

  @override
  _SettingPageState createState() => _SettingPageState();
}

enum OpzioniEnum { male, female, other }

class _SettingPageState extends State<SettingPage> {
  late UserData userData;

  IconData secondButtonIcon = Icons.home_filled;

  OpzioniEnum genere = OpzioniEnum.male;
  String trainingLevel = "Occasionally(0-1)";

  void onRadioTap(newValue) {
    setState(() => genere = newValue);
  }

  @override
  void initState() {
    super.initState();
    userData = UserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
        title: const Text(
          'Profile Settings',
          style: TextStyle(fontFamily: 'MarcellusSC', fontSize: 30),
        ),
      ),
      body: Form(
        // creation of form table
        child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
            child: ListView(children: <Widget>[
              const FormSeparator(label: 'Name'),
              TextFormField(
                controller: userData.updateNameController,
                decoration: const InputDecoration(
                  icon: Icon(
                    MdiIcons.accountSettingsOutline,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                  labelText: 'Enter your name',
                ),
              ),
              const FormSeparator(label: 'Surname'),
              TextFormField(
                controller: userData.updateSurnameController,
                decoration: const InputDecoration(
                  icon: Icon(
                    MdiIcons.accountSettingsOutline,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                  labelText: 'Enter your surname',
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.genderMaleFemaleVariant,
                            color: const Color.fromARGB(255, 50, 3, 59),
                          ),
                          const Text('Gender'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: OpzioniEnum.male,
                          groupValue: genere,
                          onChanged: onRadioTap,
                        ),
                        const Text('Male'),
                        Radio(
                          value: OpzioniEnum.female,
                          groupValue: genere,
                          onChanged: onRadioTap,
                        ),
                        const Text('Female'),
                        Radio(
                          value: OpzioniEnum.other,
                          groupValue: genere,
                          onChanged: onRadioTap,
                        ),
                        const Text('Other'),
                      ],
                    ),
                  ],
                ),
              ),
              const FormSeparator(label: 'Height (cm)'),
              TextFormField(
                controller: userData.updateHeightController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.height,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                  labelText: 'Enter your height',
                ),
              ),
              const FormSeparator(label: 'Weight (kg)'),
              TextFormField(
                controller: userData.updateWeightController,
                decoration: const InputDecoration(
                  icon: Icon(
                    MdiIcons.scaleBathroom,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                  labelText: 'Enter your weight',
                ),
              ),
              const FormSeparator(label: 'Date of birth (dd-mm-yyyy)'),
              TextFormField(
                controller: userData.updateDateOfBirthController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                  labelText: 'Enter your date of birth',
                ),
              ),
              const FormSeparator(label: 'Training level (hours/week)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 18, right: 30),
                    child: const Icon(
                      MdiIcons.run,
                      color: Color.fromRGBO(50, 3, 59, 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton(
                      value: trainingLevel,
                      underline: Container(
                        color: Colors.black54,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Occasionally(0-1)",
                          child: Text("Occasionally(0-1)"),
                        ),
                        DropdownMenuItem(
                          value: "Normal(1-3)",
                          child: Text('Normal(1-3)'),
                        ),
                        DropdownMenuItem(
                          value: "Frequent(3-5)",
                          child: Text("Frequent(3-5)"),
                        ),
                        DropdownMenuItem(
                          value: "Strong(5-8)",
                          child: Text("Strong(5-8)"),
                        ),
                        DropdownMenuItem(
                          value: "Semi-professional(8-12)",
                          child: Text("Semi-professional(8-12)"),
                        ),
                        DropdownMenuItem(
                          value: "Professional(12+)",
                          child: Text("Professional(12+)"),
                        ),
                      ],
                      onChanged: (String? newvalue) {
                        trainingLevel = newvalue!;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ])),
      ),
      //validation of the form
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
            child: const Icon(Icons.save),
            onPressed: () => _validateAndSaveDataSetting(userData),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
            child: Icon(secondButtonIcon),
            onPressed: () => _backHome(context),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
// function that permit to get back to the home
  void _backHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
// function that validate data setting
  void _validateAndSaveDataSetting(UserData userData) async {
    List<P_access> accessList = await Provider.of<DatabaseRepository>(
      context,
      listen: false,
    ).findAllP_access();
    int lastId = accessList.length;

    print(
      'name: ${userData.name}, surname: ${userData.surname}, height: ${userData.height}, weight: ${userData.weight}, dateOfBirth: ${userData.dateOfBirth}, gender: ${genere}, trainingLevel: ${trainingLevel}',
    );

    if (userData.name != null &&
        userData.surname != null &&
        userData.dateOfBirth != null) {
      P_access newAccess = P_access(
        lastId + 1,
        userData.name!,
        userData.surname!,
        userData.gender.name,
        userData.dateOfBirth!,
      );
      await Provider.of<DatabaseRepository>(context, listen: false)
          .insertP_access(newAccess);
      print('Nuovo P_access salvato');
    } else {
      print('Control: not save new P_access');
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}

class UserData extends ChangeNotifier {
  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateSurnameController = TextEditingController();
  final TextEditingController updateHeightController = TextEditingController();
  final TextEditingController updateWeightController = TextEditingController();
  final TextEditingController updateDateOfBirthController =
      TextEditingController();

  String? get name => updateNameController.text;
  String? get surname => updateSurnameController.text;
  String? get height => updateHeightController.text;
  String? get weight => updateWeightController.text;
  String? get dateOfBirth => updateDateOfBirthController.text;

  OpzioniEnum gender = OpzioniEnum.male;
  String trainingLevel = 'Occasionally(0-1)';

  void resetData() {
    updateNameController.text = 'Default';
    updateSurnameController.text = 'Default';
    updateHeightController.text = 'Default';
    updateWeightController.text = 'Default';
    updateDateOfBirthController.text = 'Default';
    gender = OpzioniEnum.male;
    trainingLevel = 'Occasionally(0-1)';
    notifyListeners();
  }
}

class FormSeparator extends StatelessWidget {
  final String label;

  const FormSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
