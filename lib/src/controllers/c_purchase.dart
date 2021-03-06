import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/controllers/c_item.dart';
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
  }) async {
    //List of Type's itens
    List<TypeItemModel> listTypes = [];
    //Get all the types in database
    listTypes = await TypeItensController().getAllActive();

    itemModel ??= ItemsModel(
      price: 0.0,
      amount: 0,
      status: 1,
    );

    TextEditingController descriptionField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController amountField = TextEditingController();

    descriptionField.text = itemModel.description ?? "";
    priceField.text =
        NumberFormat.simpleCurrency(locale: "pt_BR").format(itemModel.price);
    amountField.text =
        NumberFormat.decimalPattern('pt_BR').format(itemModel.amount);

    ///Variável for form's
    final _formKey = GlobalKey<FormState>();

    //Show the dialog
    return await showDialog<ItemsModel>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    autofocus: true,
                    controller: descriptionField,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Nome do Produto',
                      labelText: 'Produto',
                      suffix: GestureDetector(
                        onTap: () {
                          itemModel!.description = null;
                          descriptionField.text = "";
                          // setState(() {
                          //   print("Coisa");
                          // });
                          // print(itemModel.description);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Favor inserir o nome do produto!"
                          : null;
                    },
                    onChanged: (value) {
                      itemModel!.description = descriptionField.text;
                    },
                  ),
                ),
                SizedBox(height: 10),
                // PRICE'S TEXTFIELD ---------------------------------------------
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    controller: priceField,
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
                      labelText: 'Valor (Uni.|Kg)',
                      suffix: GestureDetector(
                        onTap: () {
                          itemModel!.price = 0;
                          priceField.text =
                              NumberFormat.simpleCurrency(locale: "pt_BR")
                                  .format(itemModel.price);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
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
                    controller: amountField,
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      ThousandsFormatter(
                        allowFraction: true,
                        formatter: NumberFormat.decimalPattern("pt_BR"),
                      )
                    ],
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Quantidade|Peso(Kg)',
                      labelText: 'Quantidade|Peso(Kg)',
                      suffix: GestureDetector(
                        onTap: () {
                          itemModel!.amount = 0;
                          amountField.text =
                              NumberFormat.decimalPattern('pt_BR')
                                  .format(itemModel.amount);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
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
                    value: itemModel!.typeItemId,
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

  ///This function will save the purchase
  Future<PurchasesModel?> savePurchase(PurchasesModel purchaseModel) async {
    try {
      if (purchaseModel.id == null) {
        int tempId = await ConnectionDB().getLastId("purchases") + 1;
        purchaseModel.id = tempId;
        await ConnectionDB().insertData(purchaseModel, "purchases");
        if (purchaseModel.listItensModel != null) {
          for (var item in purchaseModel.listItensModel!) {
            item.purchaseId = purchaseModel.id;
            await ItemController().saveItem(item);
          }
        }
      } else {
        await ConnectionDB()
            .updateData(purchaseModel, "purchases", purchaseModel.id!);
        if (purchaseModel.listItensModel != null) {
          for (var item in purchaseModel.listItensModel!) {
            item.purchaseId = purchaseModel.id;
            await ItemController().saveItem(item);
          }
        }
      }
      return purchaseModel;
    } catch (e) {
      print("ERROR: $e");
    }
  }

  ///This function will get all purchases
  Future<List<PurchasesModel>?> getPurchasesList() async {
    List<Map<String, dynamic>> mapPurchases;
    List<Map<String, dynamic>> mapItems = [];
    List<PurchasesModel> purchasesList = [];

    List<TypeItemModel> typeItemsList =
        await TypeItensController().getAllActive();

    //Get of the database
    mapPurchases = await ConnectionDB().getAllData(
        table: "purchases", columnsWhere: "status = ?", valueWhere: [1]);

    //Retrives all the purchase's items
    for (var item in mapPurchases) {
      mapItems = [];
      String queryItem =
          "SELECT items.id, items.purchase_id, items.type_id, items.description, items.price, items.amount, items.status, type_items.description AS name_type_item "
          "FROM items INNER JOIN type_items ON type_items.id = items.type_id WHERE items.purchase_id = ${item['id']}";
      mapItems = await ConnectionDB().getExecQuery(queryItem);
      purchasesList.add(PurchasesModel.fromJson(item, mapItems));
    }
    return purchasesList;
  }

  Future<int?> changeStatus({required PurchasesModel purchasesModel}) async {
    try {
      purchasesModel.status = 0;
      return await ConnectionDB()
          .updateData(purchasesModel, "purchases", purchasesModel.id!);
    } catch (error) {
      print("ERRO: $error");
      return 0;
    }
  }
}
