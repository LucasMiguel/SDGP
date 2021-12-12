import 'package:flutter/material.dart';
import 'package:sdgp/styles/style_main.dart';

dialogConfirm<bool>({
  required BuildContext context,
  required String title,
  required String body,
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
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Excluir",
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

// showDialog<ItensModel>(
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(title),
//         content: SizedBox(
//           height: 300,
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // PRODUCT'S TEXTFIELD ---------------------------------------------
//                 SizedBox(
//                   height: 60,
//                   child: TextFormField(
//                     initialValue:
//                         (itemModel != null ? itemModel.description : ""),
//                     textAlignVertical: TextAlignVertical.bottom,
//                     decoration: InputDecoration(
//                       border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                           borderRadius: BorderRadius.circular(15)),
//                       hintText: 'Nome do Produto',
//                       labelText: 'Produto',
//                     ),
//                     validator: (value) {
//                       return value == null || value.isEmpty
//                           ? "Favor inserir o nome do produto!"
//                           : null;
//                     },
//                     onChanged: (value) {
//                       itemModel!.description = value.toString();
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // PRICE'S TEXTFIELD ---------------------------------------------
//                 SizedBox(
//                   height: 65,
//                   child: TextFormField(
//                     initialValue: (itemModel!.price != null
//                         ? NumberFormat.simpleCurrency(locale: "pt_BR")
//                             .format(itemModel.price)
//                         : ""),
//                     textAlignVertical: TextAlignVertical.bottom,
//                     inputFormatters: [
//                       CurrencyTextInputFormatter(
//                         decimalDigits: 2,
//                         locale: 'pt_BR',
//                         customPattern: "R\$ ",
//                       )
//                     ],
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                           borderRadius: BorderRadius.circular(15)),
//                       labelText: type == 1 ? 'Valor Unitário' : 'Valor do Kg',
//                     ),
//                     validator: (value) {
//                       return value == null || value.isEmpty
//                           ? "Favor inserir o valor do produto!"
//                           : null;
//                     },
//                     onChanged: (value) {
//                       try {
//                         itemModel!.price = double.parse(value
//                             .replaceAll(',', '.')
//                             .replaceAll('R\$', '')
//                             .trim());
//                       } catch (e) {}
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // AMOUNT'S TEXTFIELD ---------------------------------------------
//                 SizedBox(
//                   height: 60,
//                   child: TextFormField(
//                     initialValue: (itemModel.amount != null
//                         ? NumberFormat.decimalPattern("pt_BR")
//                             .format(itemModel.amount)
//                         : ""),
//                     textAlignVertical: TextAlignVertical.bottom,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       type == 1
//                           ? ThousandsFormatter(
//                               allowFraction: false,
//                               formatter: NumberFormat.decimalPattern("pt_BR"),
//                             )
//                           : ThousandsFormatter(
//                               allowFraction: true,
//                               formatter: NumberFormat.decimalPattern("pt_BR"),
//                             )
//                     ],
//                     decoration: InputDecoration(
//                       border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                           borderRadius: BorderRadius.circular(15)),
//                       hintText: type == 1 ? 'Quantidade' : 'Peso (Kg)',
//                       labelText: type == 1 ? 'Quantidade' : 'Peso (Kg)',
//                     ),
//                     validator: (value) {
//                       return value == null || value.isEmpty
//                           ? "Favor inserir a quantidade!"
//                           : null;
//                     },
//                     onChanged: (value) {
//                       try {
//                         itemModel!.amount = double.parse(
//                             value.replaceAll('.', '').replaceAll(',', '.'));
//                       } catch (e) {
//                         itemModel!.amount = 0.00;
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // TYPE'S TEXTFIELD ---------------------------------------------
//                 SizedBox(
//                   height: 80,
//                   child: DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                           borderRadius: BorderRadius.circular(15)),
//                       labelText: 'Tipo',
//                     ),
//                     value: itemModel.typeItemId,
//                     items: listTypes.map((value) {
//                       return DropdownMenuItem(
//                         value: value.id,
//                         child: Text(value.description!),
//                       );
//                     }).toList(),
//                     validator: (value) {
//                       return value == null ? "Favor escolher um tipo!" : null;
//                     },
//                     onChanged: (value) {
//                       itemModel!.typeItemId = int.parse(value.toString());
//                       itemModel.nameTypeItem = listTypes
//                           .singleWhere((element) =>
//                               element.id == int.parse(value.toString()))
//                           .description;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         //======================================================================
//         // Action's buttons ====================================================
//         //======================================================================
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: Colors.red.shade300,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                     ),
//                   ),
//                 ),
//                 //Return null if is cancel
//                 onPressed: () => Navigator.pop(context, null),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.cancel,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "Cancelar",
//                         style: MainStyle().fontBtnsAlert,
//                       ),
//                     ]),
//               ),
//               OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: Colors.green.shade300,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.pop(context, itemModel);
//                   }
//                 },
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.check,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "Salvar",
//                         style: MainStyle().fontBtnsAlert,
//                       ),
//                     ]),
//               ),
//             ],
//           )
//         ],
//       );