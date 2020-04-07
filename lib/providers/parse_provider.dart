import 'package:admin/providers/http_bridge.dart';
import 'package:flutter/foundation.dart';

class ParseProvider with ChangeNotifier {
  HttpBridge bridge = HttpBridge('Workout');
}
