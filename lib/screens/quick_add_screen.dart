import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:games_revealed/theme.dart';
import 'package:games_revealed/widgets/confirm_widget.dart';
import 'package:games_revealed/widgets/input.dart';
import 'package:games_revealed/widgets/quick_list.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:smart_select/smart_select.dart';

class QuickAdd<T> {
  EdgeInsets margin;
  String hintText;
  String labelText;
  String helperText;
  String type;
  dynamic initialValue;
  String error;
  TextInputType inputType;
  TextInputAction inputAction;
  FileTypeCross fileType;
  bool autofocus;
  bool correct;
  int maxLines;
  DateFormat dateFormat;
  FocusNode node;
  Widget smartLeading;
  MaskTextInputFormatter mask;
  bool readOnly;
  T collection;
  List<Map<String, String>> items;
  List<SmartSelectOption<String>> smartOptions;
  String addRoute;
  ValueChanged<dynamic> onChanged;
  ValueChanged<dynamic> onSubmitted;

  QuickAdd({
    this.margin = const EdgeInsets.only(bottom: 10),
    this.hintText = '',
    this.labelText = '',
    this.helperText = '',
    this.type = 'text',
    this.initialValue,
    this.error,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.fileType = FileTypeCross.any,
    this.autofocus = false,
    this.correct = false,
    this.readOnly = false,
    this.maxLines,
    this.dateFormat,
    this.node,
    this.smartLeading,
    this.mask,
    this.collection,
    this.items,
    this.smartOptions,
    this.addRoute = '/quickAdd',
    this.onChanged,
    this.onSubmitted,
  });
}

class QuickAddTab {
  String name;
  List<QuickAdd> children;
  EngageParseObject collection;
  EngageParseObject parent;
  String type = 'form';
  QuickAddTab({this.name, this.children, this.collection});
  QuickAddTab.form({this.name, this.children, this.collection}) : type = 'form';
  QuickAddTab.list({this.name, this.collection, this.parent}) : type = 'list';
  QuickAddTab.media({this.name, this.collection, this.parent}) : type = 'media';
}

class QuickAddSegment<T> {
  String name;
  int index;
  QuickAddSegmentForm collection;
  EngageParseObject parent;
  List<T> list;
  QuickAddSegment(
      {this.name, this.parent, this.collection, this.list, this.index});
}

abstract class QuickAddParse extends ParseObject {
  QuickAddParse() : super('');
  QuickAddParse.clone() : this();

  @override
  clone(Map map) => QuickAddParse;

  String get tableName;

  List<QuickAdd> getForm();
  List<QuickAddSegment> getSegmentForm();
  List<QuickAddTab> getTabForm();
}

abstract class QuickAddSegmentForm {
  List<QuickAdd> getForm();
  List<QuickAddTab> getTabForm();
}

abstract class EngageParseObject extends QuickAddParse {
  String get name;
  set name(String name) => String;

  ParseFile get image;
  set image(ParseFile name);

  saveToArray(field, model);
  removeFromArray(field, model);
}

class QuickAddScreen extends HookWidget {
  // List<QuickAdd> form;
  EngageParseObject collection;
  EngageParseObject parent;
  String arrayToSave;
  dynamic model;
  final bool showAppBar;
  String addRoute;

  QuickAddScreen({
    this.collection,
    this.showAppBar = true,
    this.addRoute = '/quickAdd',
  });

  Map<int, Widget> buildSegments(List<QuickAddSegment> segments) {
    Map<int, Widget> children = <int, Widget>{
      0: Text('Details'),
    };
    for (var i = 0; i < segments.length; i++) {
      children[i + 1] = Text(segments[i].name);
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    collection = args['collection'];
    parent = args['parent'];
    arrayToSave = args['arrayToSave'];
    model = args['model'];
    if (args != null && args['addRoute'] != null) addRoute = args['addRoute'];
    if (collection != null && collection.getTabForm().isNotEmpty) {
      return buildTabPage(context, collection);
    } else if (collection != null && collection.getSegmentForm().isNotEmpty) {
      return buildSegPage(context, collection);
    } else {
      return buildSinglePage(context, collection, true, arrayToSave, model);
    }
  }

  buildSinglePage(
    context, [
    EngageParseObject collection,
    showAppBarInternal = true,
    arrayToSave,
    model,
  ]) {
    if (parent != null &&
        parent.objectId != null &&
        collection != null &&
        arrayToSave == null) {
      print(collection.tableName);
      collection.set((parent.tableName ?? '').toLowerCase(), parent,
          forceUpdate: true);
    }
    return Scaffold(
        appBar: showAppBar && showAppBarInternal
            ? AppBar(
                title: Text((collection != null && collection.objectId != null
                        ? 'Edit '
                        : 'Create ') +
                    (arrayToSave != null ? arrayToSave : collection.tableName)),
              )
            : null,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: FloatingActionButton(
                heroTag: 'buildSinglePageDelete',
                child: Icon(Icons.delete),
                backgroundColor: Colors.red,
                onPressed: () async {
                  confirmWidget(context,
                      confirmText: 'Delete!',
                      title: 'Warning!',
                      message: 'You are about to delete this item',
                      onAgreed: () async {
                    if (arrayToSave != null) {
                      await parent.removeFromArray(arrayToSave, model);
                    } else {
                      await collection.delete();
                    }
                    Navigator.pop(context);
                  });
                },
              ),
            ),
            FloatingActionButton(
              heroTag: 'buildSinglePage',
              child: Icon(Icons.save),
              onPressed: () async {
                if (arrayToSave != null) {
                  await parent.saveToArray(arrayToSave, model);
                } else {
                  await collection.save();
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    // Object's Parent Field
                    if (parent != null && arrayToSave == null)
                      buildInput(
                        QuickAdd(
                          labelText: parent.tableName + ' (parent)',
                          type: 'smartsingle',
                          collection: parent,
                          initialValue: parent.objectId,
                          readOnly: true,
                          // onChanged: (value) async =>
                          //     game = (await Game().getObject(value)).result,
                        ),
                      ),
                    if (parent != null && arrayToSave == null)
                      Column(
                        children: <Widget>[
                          Divider(
                            color: AppTheme.figmaPurple,
                            height: 18,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    if (collection != null)
                      ...collection
                          .getForm()
                          .map((value) => buildInput(value))
                          .toList()
                    else if (model != null)
                      ...model
                          .getForm()
                          .map((value) => buildInput(value))
                          .toList(),
                  ])),
            ]),
          )
        ]));
  }

  buildSegPage(context, EngageParseObject collection) {
    List<QuickAddTab> formTab = collection.getTabForm();
    List<QuickAdd> form = collection.getForm();
    List<QuickAddSegment> formSegment = collection.getSegmentForm();
    final currentSegment = useState<int>(0);
    final segmentList = buildSegments(formSegment);
    return Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(
                    (collection.objectId != null ? 'Edit ' : 'Create ') +
                        collection.tableName),
              )
            : null,
        body: Container(
            // padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
          SizedBox(
            height: 14,
          ),
          CupertinoSlidingSegmentedControl(
            backgroundColor: AppTheme.colorPurple,
            thumbColor: AppTheme.colorOrange,
            onValueChanged: (value) => currentSegment.value = value,
            children: segmentList,
            groupValue: currentSegment.value,
          ),
          if (form.length > 0 && currentSegment.value == 0)
            Expanded(child: buildSinglePage(context, collection, false)),
          ...formSegment.map((value) {
            if (form.length > 0 && currentSegment.value == value.index) {
              return Expanded(child: quickSegList(context, value));
            }
            return Text('');
          }).toList(),
        ])));
  }

  buildTabPage(context, EngageParseObject collection) {
    List<QuickAddTab> formTab = collection.getTabForm();
    return DefaultTabController(
        length: formTab.length,
        child: Scaffold(
            appBar: showAppBar
                ? AppBar(
                    title: Text(
                        (collection.objectId != null ? 'Edit ' : 'Create ') +
                            collection.tableName),
                    bottom: TabBar(
                      tabs: [
                        ...formTab
                            .map((tab) => Tab(
                                  text: tab.name,
                                ))
                            .toList()
                      ],
                    ),
                  )
                : null,
            body: TabBarView(children: [
              ...formTab.map((value) {
                if (value.type == 'form') {
                  return buildSinglePage(context, value.collection, false);
                } else {
                  return quickList(context, value);
                }
              }).toList(),
            ])));
  }

  quickList(context, value) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: QuickList(
          collection: value.collection,
          parent: value.parent,
          onTap: (item) => Navigator.pushNamed(context, addRoute, arguments: {
            'collection': item,
            'parent': value.parent,
            'addRoute': addRoute,
          }),
        ));
  }

  quickSegList(context, QuickAddSegment value) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'quickSegList',
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, addRoute, arguments: {
            'model': value.collection,
            'parent': value.parent,
            'arrayToSave': value.name.toLowerCase(),
            'addRoute': addRoute,
          }),
        ),
        body: Container(
            child: value.list == null || value.list.isEmpty
                ? Center(
                    child: Text('Empty. Add Something!',
                        style: TextStyle(fontSize: 22)))
                : ListView.builder(
                    itemCount: value.list.length,
                    itemBuilder: (context, index) {
                      var item = value.list[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            // onTap: , // view
                            leading: item.image != null
                                ? Image.network(item.image.url)
                                : null,
                            onTap: () => Navigator.pushNamed(
                                context, '/quickAdd',
                                arguments: {
                                  'model': item,
                                  'parent': value.parent,
                                  'arrayToSave': value.name.toLowerCase(),
                                  'addRoute': addRoute,
                                }),
                            title: Text(item.name),
                          ),
                          Divider(height: 1, color: Colors.grey, thickness: 1)
                        ],
                      );
                    })));
  }

  buildInput(QuickAdd qa) {
    return GRInput(
      margin: qa.margin,
      hintText: qa.hintText,
      labelText: qa.labelText,
      helperText: qa.helperText,
      type: qa.type,
      initialValue: qa.initialValue,
      error: qa.error,
      inputType: qa.inputType,
      inputAction: qa.inputAction,
      fileType: qa.fileType,
      autofocus: qa.autofocus,
      correct: qa.correct,
      readOnly: qa.readOnly,
      maxLines: qa.maxLines,
      dateFormat: qa.dateFormat,
      node: qa.node,
      smartLeading: qa.smartLeading,
      mask: qa.mask,
      collection: qa.collection,
      items: qa.items,
      smartOptions: qa.smartOptions,
      onChanged: qa.onChanged,
      onSubmitted: qa.onSubmitted,
    );
  }
}
