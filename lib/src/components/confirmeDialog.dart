import 'package:flutter/material.dart';
import 'package:sdgp/styles/style_main.dart';

dialogConfirm<bool>({
  required BuildContext context,
  required String title,
  required String body,
  required String textBtn,
  required Icon iconBtn,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.cyan.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              //Return null if is cancel
              onPressed: () => Navigator.pop(context, false),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Cancelar",
                    style: MainStyle().fontBtnsAlert,
                  ),
                ],
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconBtn,
                    SizedBox(width: 10),
                    Text(
                      textBtn,
                      style: MainStyle().fontBtnsAlert,
                    ),
                  ]),
            ),
          ],
        ),
      ],
    ),
  );
}
