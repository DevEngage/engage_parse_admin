import 'package:engage_parse_admin/models/game_model.dart';
import 'package:engage_parse_admin/project.dart';
import 'package:engage_parse_admin/routes.dart';
import 'package:engage_parse_admin/widgets/collections_list.dart';
import 'package:engage_parse_admin/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = 'Meal';
  List sections = ['Meal', 'MealGroup', 'MealIngredient'];
  Map objects = {};
  @override
  Widget build(BuildContext context) {
    List collections = [
      Game(),
    ];
    return Scaffold(
        appBar: AppBar(title: Text(Project.name), actions: routes(context)),
        body: ListView(
          children: <Widget>[
            // Container(
            //     padding: const EdgeInsets.all(16),
            //     child: EFInput(
            //       isDarkBackground: true,
            //       labelText: 'Collection',
            //       type: 'smartsingle',
            //       helperText: '',
            //       initialValue: selected,
            //       smartOptions: SmartSelectOption.listFrom<String, dynamic>(
            //           source: sections,
            //           value: (val, dynamic game) => game,
            //           title: (val, dynamic game) => game),
            //       onChanged: (value) => selected = value,
            //     )),
            Container(
                padding: const EdgeInsets.all(16),
                child: Text('Collections',
                    style: TextStyle(fontSize: 22, color: Colors.deepOrange))),
            CollectionsList(
              collections: collections,
            )
          ],
        ));
  }
}
