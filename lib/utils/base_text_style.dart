import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:flutter/material.dart';

class BaseTextStyle {
  BaseTextStyle._();

  static var chatListScreenTitle = TextStyle(color: BaseColorConstants.textPrimary, fontSize: 25, fontWeight: FontWeight.w500,);
  static var titleTextStyle = TextStyle(color: BaseColorConstants.textPrimary, fontSize: 16, fontWeight: FontWeight.w400,);
  static var subtitleTextStyle = TextStyle(color: BaseColorConstants.textSecondary, fontSize: 14, fontWeight: FontWeight.w400,);
  static var dateTimeTextStyle = TextStyle(color: BaseColorConstants.textSecondary, fontSize: 10, fontWeight: FontWeight.w400,);
}
