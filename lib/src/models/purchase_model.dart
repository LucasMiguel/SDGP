import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:sdgp/src/controllers/type_itens_controller.dart';
import 'package:sdgp/src/models/iten_model.dart';
import 'package:sdgp/src/models/type_item.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class PurchasesModel extends ChangeNotifier {
  int? id;
  String? description;
  double? totalPrice;
  String? dateCreation;
  int? type;
  List<ItensModel>? listItensModel;
  int? status;

  PurchasesModel(
      {this.id,
      this.description,
      this.totalPrice,
      this.dateCreation,
      this.type,
      this.listItensModel,
      this.status});

  factory PurchasesModel.fromJson(Map<String, dynamic> json) {
    return PurchasesModel(
      id: json['id'],
      description: json['description'],
      totalPrice: json['total_price'],
      dateCreation: json['date_creation'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'total_price': totalPrice,
      'date_creation': dateCreation,
      'type': type,
      'status': status,
    };
  }

  ///Function with is show a dialog edit for the products
  ///@param title = Title of a dialog
  ///@param itemModel = Object from manipulation
  ///@param context = context
  ///@param type = Type of item | 1 = Amount | 2 = Bunk
  Future<void> dialogEdit({
    required String title,
    required ItensModel itemModel,
    required BuildContext context,
    required int type,
  }) async {
    //List of Type's itens
    List<TypeItemModel> listTypes = [];
    //Get all the types in database
    listTypes = await TypeItensController().getAll();
    //Initialization of price
    itemModel.price = 0.00;
    //Show the dialog
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 230,
          child: Column(
            children: [
              // PRODUCT'S TEXTFIELD ---------------------------------------------
              SizedBox(
                height: 45,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  initialValue: itemModel.description,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Nome do Produto',
                    labelText: 'Produto',
                  ),
                  onChanged: (value) {
                    itemModel.description = value.toString();
                  },
                ),
              ),
              SizedBox(height: 10),
              // PRICE'S TEXTFIELD ---------------------------------------------
              SizedBox(
                height: 45,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  initialValue: NumberFormat.simpleCurrency(locale: "pt_BR")
                      .format(itemModel.price),
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
                  onChanged: (value) {
                    try {
                      itemModel.price = double.parse(value
                          .replaceAll(',', '.')
                          .replaceAll('R\$', '')
                          .trim());
                    } catch (e) {
                      itemModel.price = 0.00;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              // AMOUNT'S TEXTFIELD ---------------------------------------------
              SizedBox(
                height: 45,
                child: TextFormField(
                  initialValue: itemModel.amount.toString(),
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
                  onChanged: (value) {
                    try {
                      itemModel.amount = double.parse(
                          value.replaceAll('.', '').replaceAll(',', '.'));
                    } catch (e) {
                      itemModel.amount = 0.00;
                    }
                    print("Model ${itemModel.amount}");
                  },
                ),
              ),
              SizedBox(height: 10),
              // TYPE'S TEXTFIELD ---------------------------------------------
              SizedBox(
                height: 60,
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
                  onChanged: (value) {
                    itemModel.typeItemId = int.parse(value.toString());
                  },
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'OK'),
          //   child: const Text('OK'),
          // ),
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
                onPressed: () => Navigator.pop(context, 'Cancel'),
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
                onPressed: () => Navigator.pop(context, 'OK'),
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
