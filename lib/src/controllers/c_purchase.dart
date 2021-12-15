import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/controllers/c_type_itens.dart';
import 'package:sdgp/src/models/m_item.dart';
import 'package:sdgp/src/models/m_purchase.dart';
import 'package:sdgp/src/models/m_type_item.dart';
import 'package:sdgp/styles/style_main.dart';

class PurchaseController {
  ///Function with is show a dialog edit for the products
  ///@param title = Title of a dialog
  ///@param itemModel = Object from manipulation
  ///@param context = context
  ///@param type = Type of item | 1 = Amount | 2 = Bunk
  Future<ItemsModel?> dialogEdit({
    required String title,
    ItemsModel? itemModel,
    required BuildContext context,
    int? type,
  }) async {
    //List of Type's itens
    List<TypeItemModel> listTypes = [];
    //Get all the types in database
    listTypes = await TypeItensController().getAll();

    if (itemModel == null) {
      itemModel = ItemsModel();
      itemModel.status = 1;
      itemModel.typeAmount = type;
    }

    ///Variável for form's
    final _formKey = GlobalKey<FormState>();

    //Show the dialog
    return await showDialog<ItemsModel>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // PRODUCT'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    initialValue:
                        (itemModel != null ? itemModel.description : ""),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Nome do Produto',
                      labelText: 'Produto',
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Favor inserir o nome do produto!"
                          : null;
                    },
                    onChanged: (value) {
                      itemModel!.description = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 10),
                // PRICE'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    initialValue: (itemModel!.price != null
                        ? NumberFormat.simpleCurrency(locale: "pt_BR")
                            .format(itemModel.price)
                        : ""),
                    textAlignVertical: TextAlignVertical.bottom,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        decimalDigits: 2,
                        locale: 'pt_BR',
                        customPattern: "R\$ ",
                      )
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      labelText: type == 1 ? 'Valor Unitário' : 'Valor do Kg',
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Favor inserir o valor do produto!"
                          : null;
                    },
                    onChanged: (value) {
                      try {
                        itemModel!.price = double.parse(value
                            .replaceAll(',', '.')
                            .replaceAll('R\$', '')
                            .trim());
                      } catch (e) {}
                    },
                  ),
                ),
                SizedBox(height: 10),
                // AMOUNT'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    initialValue: (itemModel.amount != null
                        ? NumberFormat.decimalPattern("pt_BR")
                            .format(itemModel.amount)
                        : ""),
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      type == 1
                          ? ThousandsFormatter(
                              allowFraction: false,
                              formatter: NumberFormat.decimalPattern("pt_BR"),
                            )
                          : ThousandsFormatter(
                              allowFraction: true,
                              formatter: NumberFormat.decimalPattern("pt_BR"),
                            )
                    ],
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: type == 1 ? 'Quantidade' : 'Peso (Kg)',
                      labelText: type == 1 ? 'Quantidade' : 'Peso (Kg)',
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Favor inserir a quantidade!"
                          : null;
                    },
                    onChanged: (value) {
                      try {
                        itemModel!.amount = double.parse(
                            value.replaceAll('.', '').replaceAll(',', '.'));
                      } catch (e) {
                        itemModel!.amount = 0.00;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                // TYPE'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 80,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Tipo',
                    ),
                    value: itemModel.typeItemId,
                    items: listTypes.map((value) {
                      return DropdownMenuItem(
                        value: value.id,
                        child: Text(value.description!),
                      );
                    }).toList(),
                    validator: (value) {
                      return value == null ? "Favor escolher um tipo!" : null;
                    },
                    onChanged: (value) {
                      itemModel!.typeItemId = int.parse(value.toString());
                      itemModel.nameTypeItem = listTypes
                          .singleWhere((element) =>
                              element.id == int.parse(value.toString()))
                          .description;
                    },
                  ),
                ),
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
                    Navigator.pop(context, itemModel);
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

  //Function on will save the purchase
  Future<int?> SavePurchase(PurchasesModel purchaseModel) async {
    int? idtemp;
    if (purchaseModel.id == null) {
      idtemp = await ConnectionDB().getLastId('purchases');
      purchaseModel.id = idtemp;
      return await ConnectionDB().insertData(purchaseModel, "purchases");
    } else {
      return await ConnectionDB()
          .updateData(purchaseModel, "purchases", purchaseModel.id!);
    }
  }
}
