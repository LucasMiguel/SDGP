import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/src/models/iten_model.dart';
import 'package:sdgp/src/models/purchase_model.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:intl/intl.dart';

///Class with the screen purchase
class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PurchasesModel(
        totalPrice: 0.00,
        dateCreation: DateTime.now().toString(),
        listItensModel: [],
      ),
      child: PurchaseBody(),
    );
  }
}

///Widget with the purchase's body
class PurchaseBody extends StatefulWidget {
  const PurchaseBody({Key? key}) : super(key: key);

  @override
  _PurchaseBodyState createState() => _PurchaseBodyState();
}

class _PurchaseBodyState extends State<PurchaseBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Compra",
              style: MainStyle().fontTitle,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.save,
                size: 30,
              ),
            ),
          ],
        ),
        body: PurchaseForm(
          context: context,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.add_shopping_cart_rounded,
          iconTheme: IconThemeData(size: 25),
          foregroundColor: Colors.white,
          activeIcon: Icons.close,
          activeBackgroundColor: Colors.red.shade400,
          backgroundColor: const Color.fromRGBO(7, 103, 123, 1),
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          children: [
            //===== A GRANEL ===================================================
            SpeedDialChild(
                child: const Icon(
                  Icons.format_list_numbered_outlined,
                  color: Color.fromRGBO(5, 130, 202, 1),
                ),
                label: 'Unidade',
                onTap: () {
                  purchaseProvider.listItensModel!.add(ItensModel());
                  //Call the dialog
                  purchaseProvider.dialogEdit(
                    title: "Novo Produto",
                    itemModel: purchaseProvider.listItensModel!.last,
                    context: context,
                    type: 1,
                  );
                }),
            //===== UNIDADE ====================================================
            SpeedDialChild(
              child: const Icon(
                Icons.line_weight,
                color: Color.fromRGBO(0, 128, 0, 1),
              ),
              label: 'Granel',
              onTap: () {},
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color.fromRGBO(35, 152, 162, 1),
          child: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(
                    Icons.list_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(
                    Icons.auto_graph_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  @override
  Widget build(context) {
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(20),

        ///Principal Column
        child: Column(
          children: [
            Container(
              height: 90,
              width: 500,
              decoration: BoxDecoration(
                color: Color.fromRGBO(174, 193, 180, 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 8, left: 9),
                    child: Text(
                      "Total",
                      style: MainStyle().fontLabelMainPrice,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${NumberFormat.simpleCurrency(locale: "pt_BR").format(purchaseProvider.totalPrice)}",
                      textAlign: TextAlign.end,
                      style: MainStyle().fontMainPrice,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CardItem(context: context),
          ],
        ),
      );
    });
  }
}

///Widget com o item's card
class CardItem extends StatefulWidget {
  const CardItem({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(context) {
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      return Container(
        height: 100,
        width: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Color.fromRGBO(167, 238, 222, 0.17)),
        child: Column(
          children: [
            //==================================================================
            // 1nd ROW - LABEL PRODUCTS AND BUTTOMS SWITCH AND CLOSE ===========
            //==================================================================
            SizedBox(
              height: 35,
              child: Container(
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Produto",
                          style: MainStyle().fontLabelItens,
                        ),
                      ),
                    ),

                    ///Container with buttoms ----------------------------------
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(35, 152, 162, 0.56),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                                activeColor: Color.fromRGBO(167, 238, 222, 1),
                                value: true,
                                onChanged: (value) {
                                  print(value);
                                }),
                          ),
                          IconButton(
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              // var result;
                              // result = await dialogEdit();
                              // print(result.toString());
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            constraints: BoxConstraints(),
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: Colors.red.shade300,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //==================================================================
            // 2nd ROW - PRODUCT'S NAME ========================================
            //==================================================================
            Container(
              height: 25,
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                initialValue: "Nome do Produto",
                style: MainStyle().fontItenName,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            //==================================================================
            // 2nd ROW - PRODUCT'S NAME ========================================
            //==================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ROW WITH VALOR UNITÁRIO -------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valor Unitário",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      "R\$100000,00",
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
                // ROW WITH QUANTITY -----------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quant.",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      "20000",
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
                // ROW WITH TOTAL PRICE ----------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valor Total.",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      "R\$20000,00",
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
                // ROW WITH TOTAL TYPE -----------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tipo",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      "Limpeza",
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
