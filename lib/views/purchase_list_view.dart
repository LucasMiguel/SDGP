import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdgp/src/components/confirmeDialog.dart';
import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/controllers/c_purchase.dart';
import 'package:sdgp/src/models/m_purchase.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:sdgp/views/purchase_screen.dart';

// ignore: must_be_immutable
class PurchaseListView extends StatefulWidget {
  PurchaseListView({Key? key, this.purchasesList}) : super(key: key);

  List<PurchasesModel>? purchasesList;

  @override
  State<PurchaseListView> createState() => _PurchaseListViewState();
}

class _PurchaseListViewState extends State<PurchaseListView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cardList = [];
    if (widget.purchasesList != null) {
      for (var item in widget.purchasesList!) {
        cardList.add(cardPurchaseList(purchasesModel: item, context: context));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Listas de compras",
          style: MainStyle().fontTitle,
        )),
      ),
      // body: Expanded(child: DonutPieChart.withSampleData()),
      body: Column(
        children: [
          SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) => cardList[index],
            ),
          ),
        ],
      ),
    );
  }

  ///This function wiil return a widget of list card
  Widget cardPurchaseList(
      {required PurchasesModel purchasesModel, required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 63,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          // primary: Color.fromRGBO(35, 152, 162, 1),
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(color: Color.fromRGBO(35, 152, 162, 1)),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseScreen(
                purchaseModel: purchasesModel,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
                child: Text(
              "${purchasesModel.description} - ${DateFormat("dd/MM/yyyy").format(DateTime.parse(purchasesModel.dateCreation!))}",
              style: MainStyle().fontCardPurchaseList,
            )),
            IconButton(
              // constraints: BoxConstraints(),
              onPressed: () async {
                bool? choise = await dialogConfirm(
                  context: context,
                  title: "Exclusão de Lista",
                  body: "Deseja excluir essa lista?",
                  textBtn: "Excluir",
                  iconBtn: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                );
                if (choise == true) {
                  if (await PurchaseController()
                          .changeStatus(purchasesModel: purchasesModel) ==
                      1) {
                    widget.purchasesList =
                        await PurchaseController().getPurchasesList();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Excluido com sucesso !!!')),
                      );
                    });
                  }
                }
              },
              icon: Icon(
                Icons.close,
                color: Colors.red.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
