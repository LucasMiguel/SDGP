import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/src/components/confirmeDialog.dart';
import 'package:sdgp/src/components/pie_chart.dart';
import 'package:sdgp/src/controllers/c_item.dart';
import 'package:sdgp/src/controllers/c_purchase.dart';
import 'package:sdgp/src/models/m_purchase.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:intl/intl.dart';

///Class with the screen purchase
// ignore: must_be_immutable
class PurchaseScreen extends StatelessWidget {
  PurchaseScreen({
    Key? key,
    this.purchaseModel,
  }) : super(key: key);

  ///Variable with data of the save list
  PurchasesModel? purchaseModel;

  @override
  Widget build(BuildContext context) {
    purchaseModel ??= PurchasesModel(
      totalPrice: 0.00,
      description: "Sem descrição",
      dateCreation: DateTime.now().toString(),
      listItensModel: [],
      status: 1,
    );

    return ChangeNotifierProvider<PurchasesModel>.value(
      value: purchaseModel!,
      child: PurchaseBody(),
    );
  }
}

///Widget with the purchase's body
class PurchaseBody extends StatelessWidget {
  const PurchaseBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int indexSelected = 0;
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      List<Widget> screens = <Widget>[
        //Window of index 0
        PurchaseForm(context: context),
        //Window of index 1
        DonutPieChart.withSampleData(purchaseProvider.listItensModel!
            .where((element) => element.status == 1)
            .toList())
      ];

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () async {
              bool choise;
              if (!purchaseProvider.save) {
                choise = await dialogConfirm(
                    context: context,
                    title: "Sair",
                    body:
                        "Deseja realmente sair?\nTodos os dados não salvos serão perdidos!",
                    textBtn: "Sair",
                    iconBtn: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ));
                if (choise) {
                  Navigator.pop(context, true);
                }
              } else {
                Navigator.pop(context, true);
              }
            },
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: TextFormField(
              initialValue: purchaseProvider.description,
              textAlign: TextAlign.center,
              style: MainStyle().fontTitle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (value) {
                purchaseProvider.description = value.toString();
                purchaseProvider.refreshWindow();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () async {
                  PurchasesModel? tempData =
                      await PurchaseController().savePurchase(purchaseProvider);

                  if (tempData != null) {
                    purchaseProvider = tempData;
                    purchaseProvider.refreshSave();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Compra salva com sucesso!!!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Erro no salvamento da compra !!!')),
                    );
                  }
                },
                icon: Icon(
                  Icons.save,
                  color: purchaseProvider.save ? Colors.grey : Colors.green,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: screens.elementAt(indexSelected),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: Color.fromRGBO(11, 118, 140, 1),
          child: Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            var itemModel;
            //Call the dialog
            itemModel = await PurchaseController().dialogEdit(
              title: "Novo Produto",
              context: context,
            );
            if (itemModel != null) {
              itemModel.status = (itemModel.price == null ? 0 : 1);
              itemModel.price = itemModel.price ?? 0.0;
              itemModel.amount = itemModel.amount ?? 0.0;
              purchaseProvider.addNewItem(itemModel: itemModel);
            }
          },
        ),
        //======================================================================
        // BOTTOM NAVIGATION BAR ===============================================
        //======================================================================
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color.fromRGBO(35, 152, 162, 1),
          child: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(
                      Icons.list_sharp,
                      color: indexSelected == 0
                          ? Colors.green.shade300
                          : Colors.grey.shade50,
                      size: 35,
                    ),
                    onPressed: () {
                      indexSelected = 0;
                      purchaseProvider.refreshWindow();
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(
                      Icons.pie_chart_outline_outlined,
                      color: indexSelected == 1
                          ? Colors.green.shade300
                          : Colors.grey.shade50,
                      size: 35,
                    ),
                    onPressed: () {
                      indexSelected = 1;
                      purchaseProvider.refreshWindow();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

///Widget with the purchase's form
class PurchaseForm extends StatelessWidget {
  const PurchaseForm({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  Widget build(context) {
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(20),
        //Principal Column
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
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: purchaseProvider.listItensModel!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardItem(context: context, index: index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

///Widget com o item's card
class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.context,
    required this.index,
  }) : super(key: key);
  final BuildContext context;
  final int index;
  @override
  Widget build(context) {
    return Consumer<PurchasesModel>(
        builder: (context, purchaseProvider, child) {
      return Container(
        margin: EdgeInsets.only(top: 10),
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
                          //====================================================
                          // ICON STATUS =======================================
                          //====================================================
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                                activeColor: Color.fromRGBO(167, 238, 222, 1),
                                value: purchaseProvider
                                        .listItensModel![index].status ==
                                    1,
                                onChanged: (value) {
                                  //Change status of item
                                  purchaseProvider.changeStatusItem(
                                      value, index);
                                }),
                          ),
                          //====================================================
                          // ICON EDIT =========================================
                          //====================================================
                          IconButton(
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              var itemModel;
                              //Call the dialog
                              itemModel = await PurchaseController().dialogEdit(
                                title: "Novo Produto",
                                itemModel:
                                    purchaseProvider.listItensModel![index],
                                context: context,
                              );
                              if (itemModel != null) {
                                itemModel.status =
                                    (itemModel.price == null ? 0 : 1);
                                itemModel.price = itemModel.price ?? 0.0;
                                itemModel.amount = itemModel.amount ?? 0.0;
                                purchaseProvider.listItensModel![index] =
                                    itemModel;
                              }
                              purchaseProvider.refreshPrice();
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                          ),
                          //====================================================
                          // ICON DELETE =======================================
                          //====================================================
                          IconButton(
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: Colors.red.shade300,
                              size: 20,
                            ),
                            onPressed: () async {
                              bool? choise;

                              choise = await dialogConfirm(
                                  context: context,
                                  title: "Exclusão de item",
                                  body: "Deseja excluir esse item?",
                                  textBtn: "Excluir",
                                  iconBtn: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ));
                              //show the dialog wating the confirmation
                              if (choise == true) {
                                if (purchaseProvider.id != null) {
                                  ItemController().deleteItem(
                                      purchaseProvider.listItensModel![index]);
                                }
                                purchaseProvider.listItensModel!
                                    .removeAt(index);
                                purchaseProvider.refreshPrice();
                              }
                            },
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
              alignment: Alignment.centerLeft,
              height: 25,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                purchaseProvider.listItensModel![index].description!,
                style: MainStyle().fontItenName,
              ),
            ),
            //==================================================================
            // 3nd ROW - PRODUTCT'S ATTIBUTE ===================================
            //==================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ROW WITH VALOR UNITÁRIO -------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valor Uni.| Kg",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: "pt_BR").format(
                          purchaseProvider.listItensModel![index].price),
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
                // ROW WITH QUANTITY -----------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quant.| Peso(Kg)",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      NumberFormat.decimalPattern("pt_BR").format(
                          purchaseProvider.listItensModel![index].amount),
                      style: MainStyle().fontCharacttIten,
                    ),
                  ],
                ),
                // ROW WITH TOTAL PRICE ----------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valor Total",
                      style: MainStyle().fontLabelItens,
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: "pt_BR").format(
                          (purchaseProvider.listItensModel![index].amount! *
                              purchaseProvider.listItensModel![index].price!)),
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
                      purchaseProvider.listItensModel![index].nameTypeItem!,
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
