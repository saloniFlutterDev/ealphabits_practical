import 'dart:ui';

import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseWidgets {
  // toast message for app to show updates
  static toastMessage({String? title, Color? backGroundColor, ToastGravity? toastGravity}) {
    Fluttertoast.showToast(msg: title!, toastLength: Toast.LENGTH_LONG, gravity: toastGravity, timeInSecForIosWeb: 1, backgroundColor: backGroundColor, textColor: BaseColorConstants.background, fontSize: 16.0);
  }

}