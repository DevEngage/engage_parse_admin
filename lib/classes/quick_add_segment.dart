import 'package:engage_parse_admin/classes/engage_parse_object.dart';
import 'package:engage_parse_admin/classes/quick_add_segment_form.dart';

class QuickAddSegment<T> {
  String name;
  int index;
  QuickAddSegmentForm collection;
  EngageParseObject parent;
  List<T> list;
  QuickAddSegment(
      {this.name, this.parent, this.collection, this.list, this.index});
}
