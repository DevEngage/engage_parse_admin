import 'package:engage_parse_admin/classes/project.dart';
import 'package:engage_parse_admin/models/game_model.dart';
import 'package:engage_parse_admin/project.dart';
import 'package:engage_parse_admin/routes.dart';
import 'package:engage_parse_admin/widgets/collections_list.dart';
import 'package:engage_parse_admin/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class HomeScreen extends StatefulWidget {
  EngageProject project;
  List collections;
  HomeScreen({Key key, this.project, this.collections}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = 'Meal';
  List sections = ['Meal', 'MealGroup', 'MealIngredient'];
  Map objects = {};
  EngageProject project;

  @override
  void initState() {
    super.initState();
    if (widget.project != null)
      project = widget.project;
    else
      project = EngageProject();
  }

  @override
  Widget build(BuildContext context) {
    List collections = widget.collections ??
        [
          // Game(),
        ];
    return Scaffold(
        appBar: AppBar(title: Text(Project.name), actions: routes(context)),
        body: ListView(
          children: <Widget>[
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
