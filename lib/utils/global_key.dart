import 'package:flutter/cupertino.dart';

class GlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final BuildContext appContext = navigatorKey.currentContext!;
}
