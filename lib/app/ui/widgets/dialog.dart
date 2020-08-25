import 'package:clean_arc_flutter/app/misc/constants.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar

  static AlertDialog confirmDialog(
          {@required BuildContext context,
          String title,
          String content,
          FontWeight onConfirmTextFontWeight = FontWeight.normal,
          String onCancelText = 'Batalkan',
          String onConfirmText = 'Hapus',
          Color onCancelTextColor = AppConstants.COLOR_PRIMARY_COLOR,
          VoidCallback onConfirm,
          VoidCallback onCancel}) =>
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)), //this right here
        title: title == null
            ? null
            : Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        content: Text(content, style: TextStyle(letterSpacing: -0.5)),
        actions: <Widget>[
          FlatButton(
            onPressed: onCancel,
            child:
                Text(onCancelText, style: TextStyle(color: AppConstants.COLOR_PRIMARY_COLOR,fontWeight: onConfirmTextFontWeight,)),
          ),
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                  color: AppConstants.COLOR_PRIMARY_COLOR,
                  fontWeight: onConfirmTextFontWeight,
                )),
          )
        ],
      );

  static AlertDialog confirmDialogDelete(
         {@required BuildContext context,
          String title,
          String content,
          FontWeight onConfirmTextFontWeight = FontWeight.normal,
          String onCancelText = 'Batalkan',
          String onConfirmText = 'Hapus',
          Color onCancelTextColor = AppConstants.COLOR_PRIMARY_COLOR,
          VoidCallback onConfirm}) =>
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)), //this right here
        title: title == null
            ? null
            : Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        content: Text(content, style: TextStyle(letterSpacing: -0.5)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:
                Text(onCancelText, style: TextStyle(color: onCancelTextColor)),
          ),
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                  color: AppConstants.COLOR_PRIMARY_COLOR,
                  fontWeight: onConfirmTextFontWeight,
                )),
          )
        ],
      );

  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  static AlertDialog successDialog(
          {@required BuildContext context,
          @required String title,
          Widget content,
          String onConfirmText = 'Kembali',
          VoidCallback onConfirm}) =>
      AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
            color: AppConstants.COLOR_SUCCESS,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: AppConstants.COLOR_WHITE,
                  size: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.COLOR_WHITE),
                ),
              ],
            )),
        content: content,
        actions: <Widget>[
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.COLOR_BLACK,
                    fontSize: 18)),
          )
        ],
      );

  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  static AlertDialog errorDialog(
          {@required BuildContext context,
          @required String title,
          Widget icon = const RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            child: Icon(
              Icons.add_circle,
              color: AppConstants.COLOR_WHITE,
              size: 24,
            ),
          ),
          String content,
          String onConfirmText = 'Oke',
          VoidCallback onConfirm}) =>
      AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
            color: AppConstants.COLOR_ERROR,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                icon,
                Container(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.COLOR_WHITE),
                ),
              ],
            )),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.COLOR_BLACK,
                    fontSize: 18)),
          )
        ],
      );

  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  static AlertDialog customErrorDialog(
          {@required BuildContext context,
          @required String title,
          Widget icon = const RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            child: Icon(
              Icons.add_circle,
              color: AppConstants.COLOR_WHITE,
              size: 24,
            ),
          ),
          Widget content,
          String onConfirmText = 'Oke',
          VoidCallback onConfirm}) =>
      AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
            color: AppConstants.COLOR_ERROR,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                icon,
                Container(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.COLOR_WHITE),
                ),
              ],
            )),
        content: content,
        actions: <Widget>[
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.COLOR_BLACK,
                    fontSize: 18)),
          )
        ],
      );

  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  /// HATI-HATI KETIKA MENGEDIT REUSABLE WIDGET/COMPONENT
  /// Pastikan tidak merusak tampilan yang lainnya
  /// Karena REUSABLE WIDGET/COMPONENT memiliki arti widget/component ini dipakai di berbagai screen/layar
  static AlertDialog infoDialog(
          {@required BuildContext context,
          @required String title,
          String onConfirmText = 'Kembali',
          VoidCallback onConfirm}) =>
      AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
            padding: EdgeInsets.all(24),
            child: Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.COLOR_BLACK),
                ),
              ],
            )),
        actions: <Widget>[
          FlatButton(
            onPressed: onConfirm,
            child: Text(onConfirmText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.COLOR_BLACK,
                    fontSize: 18)),
          )
        ],
      );
}
