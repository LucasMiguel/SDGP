import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/src/models/purchase_model.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:intl/intl.dart';

///Class with the screen purchase
class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PurchasesModel(totalPrice: 0.00),
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
                  Icons.add_box_outlined,
                  color: Color.fromRGBO(5, 130, 202, 1),
                ),
                label: 'Granel',
                onTap: () {}),
            //===== UNIDADE ====================================================
            SpeedDialChild(
              child: const Icon(
                Icons.add_box_outlined,
                color: Color.fromRGBO(0, 128, 0, 1),
              ),
              label: 'Unidade',
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
            )
          ],
        ),
      );
    });
  }
}
