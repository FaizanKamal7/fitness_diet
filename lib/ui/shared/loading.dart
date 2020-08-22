import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: SpinKitFadingCube(
          size: 30,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                
                color: index.isEven ? Colors.grey : Colors.blueGrey,
              ),
            );
          },
        ),
      ),
    );
  }
}
