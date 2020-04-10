import 'package:engage_parse_admin/classes/quick_add_parse.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class EngageParseObject extends QuickAddParse {
  String get name;
  set name(String name) => String;

  ParseFile get image;
  set image(ParseFile name);

  saveToArray(field, model);
  removeFromArray(field, model);
}
