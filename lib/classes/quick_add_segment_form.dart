import 'package:engage_parse_admin/classes/quick_add.dart';
import 'package:engage_parse_admin/classes/quick_add_tab.dart';

abstract class QuickAddSegmentForm {
  List<QuickAdd> getForm();
  List<QuickAddTab> getTabForm();
}
