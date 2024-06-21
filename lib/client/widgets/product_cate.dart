import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Danh mục',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            _ProductItem(
              icon: Icons.mouse,
              title: 'Chuột',
            ),
            _ProductItem(
              icon: Icons.keyboard,
              title: 'Bàn phím',
            ),
            _ProductItem(
              icon: Icons.monitor,
              title: 'Màn hình',
            ),
            _ProductItem(
              icon: Icons.mouse,
              title: 'Bàn di chuột',
            ),
            _ProductItem(
              icon: Icons.headphones,
              title: 'Tai nghe',
            ),
          ],
        ),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  final IconData icon;
  final String title;

  _ProductItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Icon(
              icon,
              size: 32.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
