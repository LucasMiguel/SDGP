import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/src/models/purchase_model.dart';
import 'package:sdgp/styles/style_main.dart';

///Class with the screen purchase
class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PurchasesModel(),
      child: PurchaseBody(
        context: context,
      ),
    );
  }
}

///Widget with the purchase's body
class PurchaseBody extends StatefulWidget {
  const PurchaseBody({Key? key, required this.context}) : super(key: key);
  final BuildContext context;

  @override
  _PurchaseBodyState createState() => _PurchaseBodyState();
}

class _PurchaseBodyState extends State<PurchaseBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, purchaseModel, child) {
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
        // floatingActionButton: SpeedDial(
        //   animatedIcon: AnimatedIcons.menu_close,
        //   backgroundColor: const Color.fromRGBO(5, 130, 202, 1),
        //   overlayColor: Colors.grey,
        //   overlayOpacity: 0.5,
        //   spacing: 15,
        //   spaceBetweenChildren: 15,
        //   children: [
        //     //===== NOVA ATIVIDADE =============================================
        //     SpeedDialChild(
        //         child: const Icon(
        //           Icons.bookmark_add,
        //           color: Color.fromRGBO(5, 130, 202, 1),
        //         ),
        //         label: 'Nova Atividade',
        //         onTap: () {}),
        //     //===== FINALIZAR RDO ==============================================
        //     SpeedDialChild(
        //       child: const Icon(
        //         Icons.checklist_sharp,
        //         color: Color.fromRGBO(0, 128, 0, 1),
        //       ),
        //       label: 'Finalizar',
        //       onTap: () {},
        //     ),
        //     //===== ATIVAR =====================================================
        //     SpeedDialChild(
        //       child: const Icon(
        //         Icons.upload,
        //         color: Color.fromRGBO(5, 130, 202, 1),
        //       ),
        //       label: 'Ativar',
        //       onTap: () {},
        //     ),
        //     //===== REMOVER ====================================================
        //     SpeedDialChild(
        //       child: const Icon(
        //         Icons.delete,
        //         color: Color.fromRGBO(227, 0, 0, 1),
        //       ),
        //       label: 'Excluir',
        //       onTap: () => showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) => AlertDialog(
        //           title: const Text('Exclusão de RDO'),
        //           content: const Text(
        //               'Deseja excluir essa RDO, os dados serão perdidos?'),
        //           actions: <Widget>[
        //             TextButton(
        //               onPressed: () => Navigator.pop(context, 'Cancelar'),
        //               child: const Text(
        //                 'Cancelar',
        //                 style: TextStyle(fontWeight: FontWeight.bold),
        //               ),
        //             ),
        //             TextButton(
        //               onPressed: () {
        //                 // if (rdoFinal != null) {
        //                 //   //Irá fazer a exclusão no banco de dados, caso já esteja cadastrado
        //                 // }
        //                 Navigator.pop(context, 'OK');
        //                 Navigator.pop(context);
        //               },
        //               child: const Text(
        //                 'Exluir',
        //                 style: TextStyle(
        //                     color: Colors.red, fontWeight: FontWeight.bold),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // bottomNavigationBar: BottomAppBar(
        //   shape: CircularNotchedRectangle(),
        //   child: Container(
        //     height: 50,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         IconButton(
        //           iconSize: 30.0,
        //           padding: EdgeInsets.only(left: 28.0),
        //           icon: Icon(Icons.home),
        //           onPressed: () {},
        //         ),
        //         IconButton(
        //           iconSize: 30.0,
        //           padding: EdgeInsets.only(right: 28.0),
        //           icon: Icon(Icons.search),
        //           onPressed: () {},
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      );
    });
  }
}
