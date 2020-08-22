import 'package:flutter/material.dart';


typedef Responsive_Builder = Widget Function(
  BuildContext context,
  Size,
);

class ResponsiveSafeArea extends StatelessWidget {
  final Responsive_Builder responsive_Builder;

  const ResponsiveSafeArea({
    Key key,
    @required Responsive_Builder builder,
  })  : responsive_Builder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return responsive_Builder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}
