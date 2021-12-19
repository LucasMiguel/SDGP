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

///This dialogic wiil be to insert a description for the purchase
Future<String?> dialogDescription({
  required BuildContext context,
}) async {
  final _formKey = GlobalKey<FormState>();
  String description = "";
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Descrição da Compra"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(15)),
            labelText: "Descrição",
            helperText: "Descrição da Compra",
          ),
          validator: (value) {
            return value == null || value.isEmpty
                ? "Favor inserir uma descrição!!"
                : null;
          },
          onChanged: (value) {
            description = value;
          },
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              //Return null if is cancel
              onPressed: () => Navigator.pop(context, null),
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
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, description);
                }
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Salvar",
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
