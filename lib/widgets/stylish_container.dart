// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class StylishContainer extends StatelessWidget {
  final Widget child;

  const StylishContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Center(child: child),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          //darker shadow
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(5, 5),
            blurRadius: 15,
          ),

          //lighter shadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 15,
          ),
        ],
      ),
    );
  }
}
