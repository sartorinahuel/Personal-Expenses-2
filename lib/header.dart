import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_personal_expenses_2/homepage.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Background(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _CuentaBar(),
                _Saldo(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CuentaBar extends StatelessWidget {
  const _CuentaBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Caja de Ahorro",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {},
        )
      ],
    );
  }
}

class _Saldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pos = Provider.of<ScrollProvider>(context).scrollMovement;
    final double total = Provider.of<ScrollProvider>(context).total;

    double saldoToLeft = 0;
    double montoToRight = 0;
    double saldoUp = 0;
    double montoUp = 0;
    double montoFontSize = 0;
    double containerSize;

    if (pos >= 1) {
      saldoToLeft = 15;
      saldoUp = 0;
      montoToRight = 0;
      montoUp = 0;
      montoFontSize = 20;
      containerSize = 150;
    } else {
      saldoToLeft = (size.width * 0.5 - 63) - (size.width * 0.5 - 78) * pos;
      saldoUp = 30 * (1 - pos);
      montoToRight = (size.width * 0.5 - 158) * (1 - pos);
      montoUp = 60 * (1 - pos);
      montoFontSize = 55 - (35 * pos);
      containerSize = 300 - (150 * pos);
    }

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: saldoUp,
            left: saldoToLeft,
            child: Container(
              width: 110,
              child: Text(
                "Saldo actual",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Positioned(
            top: montoUp,
            right: montoToRight,
            child: Container(
              width: containerSize,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$ ${total.truncate()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: montoFontSize,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    (total - total.truncate())
                        .toStringAsFixed(2)
                        .substring(1, 4),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double pos = Provider.of<ScrollProvider>(context).scrollMovement;

    if (pos > 1) {
      pos = 1;
    }

    return Container(
      height: size.height * (0.35 - 0.2 * pos),
      width: double.infinity,
      child: CustomPaint(
        painter: _BackgroundPainter(pos),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double pos;

  _BackgroundPainter(this.pos);

  final Gradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF08D2A), //f57e1a
      Color(0xFFf06e2a),
    ],
  );

  final Rect rect = Rect.fromCircle(center: Offset(150, 150), radius: 100);

  @override
  void paint(Canvas canvas, Size size) {
    final double dif = 1 - pos;
    final lapiz = Paint()..shader = gradient.createShader(rect);

    //Propiedades del lápiz
    lapiz.color = Colors.orange[900];
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 10;

    final path = Path();

    //Dibujo

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height - (30 * dif),
        size.width * 0.45, size.height - (15 * dif));
    path.quadraticBezierTo(
        size.width * 0.78, size.height, size.width, size.height - (70 * dif));
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
