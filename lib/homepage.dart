import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_personal_expenses_2/header.dart';
import 'package:flutter_personal_expenses_2/transactions.dart';

class HomePage extends StatelessWidget {
  // var _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   _selectedIndex = index;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ScrollProvider(),
        child: Stack(
          children: [
            Transactions(),
            Header(),
          ],
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
  double _monto = 0.0;

  double get scrollPosotion => this._scrollPosition;
  double get monto => this._monto;

  set setScrollPosition(double p) {
    _scrollPosition = p;
    notifyListeners();
  }

  set setmonto(double p) {
    _monto = p;
    notifyListeners();
  }
}
