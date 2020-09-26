import 'package:flutter/material.dart';
import 'package:flutter_personal_expenses_2/homepage.dart';
import 'package:provider/provider.dart';

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
    final pos = Provider.of<ScrollProvider>(context).scrollPosotion;

    double saldoToRight = 0;
    double montoToLeft = 0;
    double saldoUp = 0;
    double montoUp = 0;
    double montoFontSize = 0;

    if (pos > size.width * 0.28) {
      saldoToRight = size.width * 0.28;
      saldoUp = 30;
    } else {
      saldoToRight = pos;
      saldoUp = 22 * (pos / (size.width * 0.2));
    }

    if (pos > size.width * 0.20) {
      montoToLeft = size.width * 0.2;
      montoUp = 70;
      montoFontSize = 35;
    } else {
      montoToLeft = pos;
      montoUp = 70 * (pos / (size.width * 0.20));
      montoFontSize = 35 * (pos / (size.width * 0.20));
    }

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 30 - saldoUp,
            right: saldoToRight - 8,
            child: Container(
              width: size.width,
              child: Align(
                child: Text(
                  "Saldo actual",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70 - montoUp,
            left: montoToLeft - 8,
            child: Container(
              width: size.width,
              child: Align(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$ 15.470",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55 - montoFontSize,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      ".47",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
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
    final pos = Provider.of<ScrollProvider>(context).scrollPosotion;

    double heightReduc = 0;

    if (pos > size.width * 0.4) {
      heightReduc = size.width * 0.4;
    } else {
      heightReduc = pos;
    }

    return Container(
      height: size.height * 0.35 - heightReduc,
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

  double curveHeight1 = 0;
  double curveHeight2 = 0;
  double centerHeight = 0;

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
    final lapiz = Paint()..shader = gradient.createShader(rect);

    //Propiedades del lápiz
    lapiz.color = Colors.orange[900];
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 10;

    final path = Path();

    //Dibujo

    if (pos > 30) {
      curveHeight1 = 30;
    } else {
      curveHeight1 = pos;
    }

    if (pos > 70) {
      curveHeight2 = 70;
    } else {
      curveHeight2 = pos;
    }

    if (pos > 15) {
      centerHeight = 15;
    } else {
      centerHeight = pos;
    }

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height - 30 + curveHeight1,
        size.width * 0.45, size.height - 15 + centerHeight);
    path.quadraticBezierTo(size.width * 0.78, size.height, size.width,
        size.height - 70 + curveHeight2);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
