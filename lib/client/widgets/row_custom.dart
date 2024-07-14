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
        Expanded(
          child: Text(
            lable!,
            style: const TextStyle(fontSize: 20),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
