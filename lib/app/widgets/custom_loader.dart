import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Image.asset('assets/image/loadingdots2-unscreen.gif'),
      ),
    );
  }
}

class CustomLoader2 extends StatelessWidget {
  const CustomLoader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Image.asset('assets/image/blackLoading-unscreen.gif'),
      ),
    );
  }
}

