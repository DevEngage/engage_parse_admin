import 'package:engage_parse_admin/classes/engage_parse_object.dart';
import 'package:engage_parse_admin/classes/quick_add.dart';

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
