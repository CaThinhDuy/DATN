import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RowCustom extends StatelessWidget {
  final IconData? icon;
  final String? lable;
  const RowCustom({super.key, this.lable, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          lable!,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
