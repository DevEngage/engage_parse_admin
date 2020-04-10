import 'package:engage_parse_admin/classes/quick_add.dart';
import 'package:engage_parse_admin/classes/quick_add_segment.dart';
import 'package:engage_parse_admin/classes/quick_add_tab.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
