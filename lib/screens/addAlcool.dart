import 'package:flow1_prova/screens/alcoolPage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';
import 'package:flow1_prova/widget/formTiles.dart';
import 'package:flow1_prova/widget/formSeparator.dart';
import 'package:provider/provider.dart';

class AddAlcool extends StatefulWidget {
  final Alcool? init_alcool;

  const AddAlcool({Key? key, required this.init_alcool}) : super(key: key);

  static const routeDisplayName = 'AddAlcool';

  @override
  State<AddAlcool> createState() => _AddAlcoolState();
} 

class _AddAlcoolState extends State<AddAlcool> {
  
  final formKey = GlobalKey<FormState>();

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  @override
  void initState() {
    _controller1.text = widget.init_alcool == null ? '' : widget.init_alcool!.type.toString();
    _controller2.text = widget.init_alcool == null ? '' : widget.init_alcool!.volume.toString();
    _controller3.text = widget.init_alcool == null ? '' : widget.init_alcool!.quantity.toString();
    _controller4.text = widget.init_alcool == null ? '' : widget.init_alcool!.percentage.toString();
    _controller5.text = widget.init_alcool == null ? '' : widget.init_alcool!.hour.toString();
    _controller6.text = widget.init_alcool == null ? '' : widget.init_alcool!.day.toString();
    super.initState();
  } 

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
        title: const Text(AddAlcool.routeDisplayName),
        actions: [
          IconButton(
            onPressed: () => _validateAndSave(context),
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.init_alcool == null
          ? null
          : FloatingActionButton(
              backgroundColor: const Color.fromRGBO(135, 47, 183, .9),
              onPressed: () => _deleteAndPop(context, widget.init_alcool!),
              child: const Icon(Icons.delete),
            ),
    );
  } //build

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            const FormSeparator(label: 'Type'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 18, right: 30),
                  child: const Icon(
                    MdiIcons.glassCocktail,
                    color: Color.fromRGBO(50, 3, 59, 1),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButton(
                      iconSize: 16,
                      value: _controller1.text.isEmpty ? null : _controller1.text,
                      hint: const Text('Select Type', style: TextStyle(fontSize: 16)),
                      style: const TextStyle(color: Colors.black),
                      items: const [
                        DropdownMenuItem(
                          value: 'Beer',
                          child: Text('Beer'),
                        ),
                        DropdownMenuItem(
                          value: "Wine",
                          child: Text('Wine'),
                        ),
                        DropdownMenuItem(
                          value: "Cocktail",
                          child: Text("Cocktail"),
                        ),
                        DropdownMenuItem(
                          value: "Other",
                          child: Text("Other"),
                        ),
                      ],
                      onChanged: (String? newvalue) {
                        _controller1.text = newvalue!;
                        setState(() {});
                      }),
                )
              ],
            ),
            
            const FormSeparator(label: 'Volume (L)'),
            FormNumberTile(
              labelText: 'Volume',
              controller: _controller2,
              icon: MdiIcons.flaskOutline,
            ),
            const FormSeparator(label: 'Quantity (PCs)'),
            FormNumberTile(
              labelText: 'Quantity',
              controller: _controller3,
              icon: MdiIcons.bookmarkPlus,
            ),
            const FormSeparator(label: 'Percentage (%)'),
            FormNumberTile(
              labelText: 'Percentage',
              controller: _controller4,
              icon: MdiIcons.percent,
            ),
            const FormSeparator(label: 'Hour (0-24)'),
            FormNumberTile(
              labelText: 'Hour',
              controller: _controller5,
              icon: MdiIcons.timetable,
            ),
            const FormSeparator(label: 'Day (yyyy-mm-dd)'),
            TextFormField(
                controller: _controller6,
                decoration: const InputDecoration(icon: Icon(MdiIcons.clockTimeFourOutline), labelText: 'Day')),
          ],
        ),
      ),
    );
  } // _buildForm

  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (widget.init_alcool == null) {
        Alcool newAlcool = Alcool(
          null,
          _controller6.text,
          _controller1.text,
          int.parse(_controller3.text),
          int.parse(_controller5.text),
          double.parse(_controller2.text),
          double.parse(_controller4.text),
        );
        await Provider.of<DatabaseRepository>(context, listen: false).insertAlcool(newAlcool);
      } else {
        Alcool updatedAlcool = Alcool(
          widget.init_alcool!.id,
          _controller6.text,
          _controller1.text,
          int.parse(_controller3.text),
          int.parse(_controller5.text),
          double.parse(_controller2.text),
          double.parse(_controller4.text),
        );

        await Provider.of<DatabaseRepository>(context, listen: false).updateAlcool(updatedAlcool);
        Navigator.pop(context);
      } //else
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AlcoolPage()));
    } //if
  } //_validateAndSave

  void _deleteAndPop(BuildContext context, Alcool alcooltorem) async {
    await Provider.of<DatabaseRepository>(context, listen: false).removeAlcool(alcooltorem); //alcooltorem);
    // Navigator.pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AlcoolPage()));
  } //_deleteAndPop
} //alcoolPage
