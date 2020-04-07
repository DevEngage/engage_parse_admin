import 'package:flutter/material.dart';
import 'package:games_revealed/screens/quick_add_screen.dart';
import 'package:games_revealed/widgets/input.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class QuickList extends StatefulWidget {
  final List<EngageParseObject> list;
  final EngageParseObject collection;
  final EngageParseObject parent;
  final onTap;
  final onLongPress;
  final addRoute;
  final appBar;
  QuickList({
    Key key,
    this.list = const [],
    this.onTap,
    this.onLongPress,
    this.collection,
    this.parent,
    this.addRoute = '/quickAdd',
    this.appBar,
  }) : super(key: key);

  @override
  _QuickListState createState() => _QuickListState();
}

class _QuickListState extends State<QuickList> {
  List<EngageParseObject> quickList = [];
  bool isLoading = false;
  String searchTerm = '';
  @override
  void initState() {
    super.initState();
    if (widget.collection != null) {
      getList();
    } else {
      quickList = widget.list;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  getList() async {
    QueryBuilder query = QueryBuilder(widget.collection);
    if (widget.parent != null) {
      query.whereEqualTo(
          (widget.parent.tableName.toLowerCase() ?? ''), widget.parent);
    }
    ParseResponse response = await query.query();
    setState(() {
      if (response.success) {
        quickList = List<EngageParseObject>.from(response.results ?? []);
      } else {
        quickList = [];
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, widget.addRoute,
              arguments: {
                'collection': widget.collection,
                'parent': widget.parent
              }),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: GRInput(
                  isDarkBackground: true,
                  labelText: 'Search',
                  // helperText: 'e.g. hello@engagefitness.io',
                  // initialValue: usersProvider.profile.lastName,
                  onChanged: (value) =>
                      setState(() => searchTerm = (value ?? '').toLowerCase()),
                )),
            for (EngageParseObject item in (quickList ?? [])
                .where((element) =>
                    (element.name ?? '').toLowerCase().contains(searchTerm))
                .toList())
              // EngageParseObject item = quickList[index];
              Column(children: <Widget>[
                ListTile(
                  // onTap: , // view
                  leading:
                      item.image != null ? Image.network(item.image.url) : null,
                  onTap: () =>
                      widget.onTap != null ? widget.onTap(item) : null, // edit
                  onLongPress: widget.onLongPress, // edit
                  title: Text(item.name),
                  // subtitle: Text(item.body),
                ),
                Divider(height: 1, color: Colors.grey, thickness: 1)
              ])
          ],
        )));
  }
}
