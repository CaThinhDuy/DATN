import 'package:flutter/material.dart';

class UpDownWidget extends StatefulWidget {
  const UpDownWidget({super.key});

  @override
  _UpDownWidgetState createState() => _UpDownWidgetState();
}

class _UpDownWidgetState extends State<UpDownWidget> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 255, 92, 52)),
      padding: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 25,
              color: Colors.white,
            ),
            onPressed: decrementCounter,
          ),
          const SizedBox(width: 18.0),
          Text(
            '$counter',
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 18.0,
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
            onPressed: incrementCounter,
          ),
        ],
      ),
    );
  }
}
