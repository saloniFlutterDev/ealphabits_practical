
import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:flutter/material.dart';

import 'base_text_style.dart';


class BaseButtons {

  Widget button({required void Function() onPressed, required BuildContext context, required String title, bool isBordered = false, bool isNoBorderRadius = false}) {
    return ElevatedButton(
      style: isBordered
          ? ButtonStyle(
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: BaseColorConstants.primary,
                ),
              ),
              backgroundColor: WidgetStateProperty.all(BaseColorConstants.primary),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: isNoBorderRadius ? BorderRadius.circular(10.0) : BorderRadius.circular(40.0),
                side: BorderSide(
                  color: BaseColorConstants.primary,
                  width: 1,
                ),
              )),
              alignment: Alignment.center,
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              ),
            )
          : ButtonStyle(
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontFamily: "OpenSans",
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: BaseColorConstants.surface,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(BaseColorConstants.primary),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
          alignment: Alignment.center,
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 7, horizontal: 8))
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: isBordered
            ? BaseTextStyle.buttonTextStyle
            : BaseTextStyle.titleTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget greyBorderButton({required void Function() onPressed, required BuildContext context, required String title,  bool isNoBorderRadius = false}) {
    return ElevatedButton(
      style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: BaseColorConstants.surface,
                ),
              ),
              backgroundColor: WidgetStateProperty.all(BaseColorConstants.surface),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:  BorderRadius.circular(10.0),
                side: BorderSide(
                  color: BaseColorConstants.textSecondary,
                  width: 1,
                ),
              )),
              alignment: Alignment.center,
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              ),
            ),
      onPressed: onPressed,
      child: Text(
        title,
        style:BaseTextStyle.titleTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
