import 'package:flutter/material.dart';

class UpDownWidget extends StatefulWidget {
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 255, 92, 52)),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove,
              size: 25,
              color: Colors.white,
            ),
            onPressed: decrementCounter,
          ),
          SizedBox(width: 18.0),
          Text(
            '$counter',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 18.0,
          ),
          IconButton(
            icon: Icon(
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
