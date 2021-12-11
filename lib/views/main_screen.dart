import 'package:flutter/material.dart';
import 'package:sdgp/styles/style_main.dart';
import 'package:sdgp/views/purchase_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 118, 140, 1),
      body: Center(
        child: Column(
          children: [
            //==================================================================
            // LOGO ============================================================
            //==================================================================
            Container(
              margin: EdgeInsets.only(top: 150),
              child: Image(
                image: AssetImage('images/logo_vertical.png'),
                width: 150,
              ),
            ),
            //==================================================================
            // BUTTOM 'NOVA COMPRA' ============================================
            //==================================================================
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Color.fromRGBO(8, 108, 129, 1),
                      fixedSize: Size(318, 63),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Nova Compra",
                            style: MainStyle().fontMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //==================================================================
            // BUTTOM 'LISTA DE COMPRAS' =======================================
            //==================================================================
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Color.fromRGBO(8, 108, 129, 1),
                      fixedSize: Size(318, 63),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.format_list_bulleted_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Listas de Compras",
                            style: MainStyle().fontMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //==================================================================
            // BUTTOM 'HISTÓRICO DE COMPRAS' ===================================
            //==================================================================
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Color.fromRGBO(8, 108, 129, 1),
                      fixedSize: Size(318, 63),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.list_alt_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Histór. de Compras",
                            style: MainStyle().fontMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
