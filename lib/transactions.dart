import 'package:flutter/material.dart';
import 'package:flutter_personal_expenses_2/homepage.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      Provider.of<ScrollProvider>(context, listen: false).setScrollPosition =
          scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        controller: scrollController,
        children: [
          SizedBox(height: 270),
          Text("Transacciones", style: TextStyle(fontSize: 16)),
          TransactionCard(
            monto: -2458.65,
            titulo: "Compra chino",
            descripcion: "cosas para el asado",
          ),
          TransactionCard(
            monto: 750.0,
            titulo: "Soporte Andrés H.",
            descripcion: "Reparación del sonido",
          ),
          TransactionCard(
            monto: -650,
            titulo: "Compra pantalón",
            descripcion: "Jogging",
          ),
          TransactionCard(
            monto: -590,
            titulo: "Combustible Moto",
            descripcion: "lleno",
          ),
          TransactionCard(
            monto: 12000,
            titulo: "Soporte Galia",
            descripcion: "Mensualidad",
          ),
          TransactionCard(
            monto: -6540,
            titulo: "Compra Estabilizadores",
            descripcion: "2x Estabilizadores para RIG",
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final double monto;

  const TransactionCard({
    Key key,
    @required this.titulo,
    this.descripcion = "",
    @required this.monto,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.red),
      ),
      key: UniqueKey(),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            padding: const EdgeInsets.all(10),
            // height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.grey
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      descripcion,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 5),
                              Text("6 Sep 2020"),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 20,
            child: Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.arrow_drop_up,
                        size: 50,
                        color:
                            monto > 0 ? Colors.green[700] : Colors.grey[300]),
                    Icon(Icons.arrow_drop_down,
                        size: 50,
                        color: monto < 0 ? Colors.red[700] : Colors.grey[300]),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF08D2A),
                          Color(0xFFf06e2a),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Align(
                    child: Text(
                      "\$ $monto",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
