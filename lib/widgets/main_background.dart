import 'package:flutter/material.dart';

// Pone el color negro de fondo

class MainBackground extends StatelessWidget {
  final Widget child;

  const MainBackground({Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _boxDecorationScaffold(),

      child: this.child,
    );
  }


  BoxDecoration _boxDecorationScaffold() {
    return const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.black87,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.3]
        )
    );
  }

}