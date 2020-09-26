import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_personal_expenses_2/header.dart';
import 'package:flutter_personal_expenses_2/transactions.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ScrollProvider(),
        child: Builder(
          builder: (BuildContext context) {
            Provider.of<ScrollProvider>(context, listen: false)
                .setScrollTarget = MediaQuery.of(context).size.height * 0.22;
            return Stack(
              children: [
                Transactions(),
                Header(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _BottomBar(),
    );
  }
}

class _BottomBar extends StatefulWidget {
  @override
  __BottomBarState createState() => __BottomBarState();
}

class __BottomBarState extends State<_BottomBar> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(color: Color(0xFFf06e2a)),
      fixedColor: Color(0xFFf06e2a),
      backgroundColor: Colors.white,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.account_balance_wallet),
          title: new Text('Cuentas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Perfil'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Más'),
        ),
      ],
    );
  }
}

class ScrollProvider with ChangeNotifier {
  double _scrollPosition = 0.0;
  double _scrollMovement = 0.0;
  double _scrollTarget;
  double _monto = 0.0;

  List<Transaction> _txs = [
    Transaction(1, -2458.65, "Compra supermercado", "Comida para el asado"),
    Transaction(2, 750, "Soporte Remoto Jorge", "Reparación del sonido"),
    Transaction(3, -650, "Compra pantalón", "Jogging"),
    Transaction(4, -590, "Combustible Moto", "Tanque lleno"),
    Transaction(5, 12450, "Soporte IT", "Factura de soporte mensual"),
    Transaction(6, -6500, "Compra Estabilizadores", "Para PC"),
    Transaction(7, 8530, "Venta auriculares", "Mercado Libre"),
  ];

  double get scrollPosotion => this._scrollPosition;
  double get scrollMovement => this._scrollMovement;
  List<Transaction> get transactions => this._txs;
  double get total {
    _monto = 0;
    _txs.forEach(
      (element) {
        _monto += element.monto;
      },
    );
    return _monto;
  }

  set setScrollTarget(double p) {
    _scrollTarget = p;
  }

  set setScrollPosition(double p) {
    _scrollPosition = p;
    _scrollMovement = _scrollPosition / _scrollTarget;
    notifyListeners();
  }

  set setmonto(double p) {
    _monto = p;
    notifyListeners();
  }

  void deleteTX(int i) {
    _txs.removeWhere((element) => element.id == i);
    notifyListeners();
  }
}
