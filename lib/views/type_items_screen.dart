import 'package:flutter/material.dart';
import 'package:sdgp/src/controllers/c_type_itens.dart';
import 'package:sdgp/src/models/m_type_item.dart';
import 'package:sdgp/styles/style_main.dart';

// ignore: must_be_immutable
class TypeItemListView extends StatefulWidget {
  TypeItemListView({Key? key, this.typeItemsList}) : super(key: key);

  List<TypeItemModel>? typeItemsList;

  @override
  State<TypeItemListView> createState() => _TypeItemListViewState();
}

class _TypeItemListViewState extends State<TypeItemListView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cardList = [];
    if (widget.typeItemsList != null) {
      for (var item in widget.typeItemsList!) {
        cardList.add(cardTypeItemList(typeItemModel: item, context: context));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Tipos de Items",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? description = await TypeItensController()
              .dialogEdit(title: "Novo Tipo", context: context);
          if (description != null) {
            TypeItemModel newTypeItem =
                TypeItemModel(description: description, status: 1);
            newTypeItem.id = await TypeItensController().saveItem(newTypeItem);
            widget.typeItemsList = await TypeItensController().getAll();
            setState(() {});
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  ///This function wiil return a widget of list card
  Widget cardTypeItemList(
      {required TypeItemModel typeItemModel, required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 63,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          // primary: Color.fromRGBO(35, 152, 162, 1),
          primary:
              typeItemModel.status == 1 ? Colors.white : Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(color: Color.fromRGBO(35, 152, 162, 1)),
          ),
        ),
        onPressed: () async {
          String? descTemp = await TypeItensController().dialogEdit(
              title: "Editar tipo",
              context: context,
              description: typeItemModel.description);
          if (descTemp != null) {
            typeItemModel.description = descTemp;
            await TypeItensController().saveItem(typeItemModel);
            setState(() {});
          }
        },
        child: Row(
          children: [
            Expanded(
                child: Text(
              "${typeItemModel.description}",
              style: MainStyle().fontCardPurchaseList,
            )),
            Switch(
                activeColor: Color.fromRGBO(167, 238, 222, 1),
                value: typeItemModel.status == 1,
                onChanged: (value) async {
                  typeItemModel.status = value ? 1 : 0;
                  await TypeItensController().saveItem(typeItemModel);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}
