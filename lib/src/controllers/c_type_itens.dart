import 'package:flutter/material.dart';
import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/models/m_type_item.dart';
import 'package:sdgp/styles/style_main.dart';

class TypeItensController {
  ///Function returns a list of items
  Future<List<TypeItemModel>> getAllActive() async {
    List<Map<String, dynamic>> map;
    List<TypeItemModel> listTypes = [];
    map = await ConnectionDB().getExecQuery(
        "SELECT * FROM type_Items WHERE status = 1 ORDER BY description ASC");
    for (var item in map) {
      listTypes.add(TypeItemModel.fromJson(item));
    }
    return listTypes;
  }

  ///Function returns a list of items
  Future<List<TypeItemModel>> getAll() async {
    List<Map<String, dynamic>> map;
    List<TypeItemModel> listTypes = [];
    map = await ConnectionDB()
        .getExecQuery("SELECT * FROM type_Items ORDER BY description ASC");
    for (var item in map) {
      listTypes.add(TypeItemModel.fromJson(item));
    }
    return listTypes;
  }

  ///This function will save the item's types
  Future<int?> saveItem(TypeItemModel typeItemModel) async {
    if (typeItemModel.id == null) {
      int tempId = await ConnectionDB().getLastId("type_Items") + 1;
      typeItemModel.id = tempId;
      return await ConnectionDB().insertData(typeItemModel, "type_Items");
    } else {
      return await ConnectionDB()
          .updateData(typeItemModel, "type_Items", typeItemModel.id!);
    }
  }

  ///This fuction will show the dialog for insert or edit item's type
  Future<String?> dialogEditTypeItem({
    required String title,
    String? description,
    required BuildContext context,
    int? type,
  }) async {
    ///Variável for form's
    final _formKey = GlobalKey<FormState>();

    //Show the dialog
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: SizedBox(
          height: 75,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // PRODUCT'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    initialValue: (description ?? ""),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Tipo do Produto',
                      labelText: 'Tipo',
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Favor inserir o nome do produto!"
                          : null;
                    },
                    onChanged: (value) {
                      description = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        //======================================================================
        // Action's buttons ====================================================
        //======================================================================
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
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
                    ]),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green.shade300,
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
                        Icons.check,
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
          )
        ],
      ),
    );
  }
}
