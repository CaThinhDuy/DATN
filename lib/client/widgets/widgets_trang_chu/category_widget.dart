import 'package:flutter/material.dart';
typedef OnCategorySelected = void Function(int categoryId);

class CategoryWidget extends StatefulWidget {
  final OnCategorySelected onCategorySelected;

  const CategoryWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100.0, // Adjust the height as needed
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildCategoryButton(0, 'Tất cả', Icons.apps),
            _buildCategoryButton(1, 'Chuột', Icons.mouse),
            _buildCategoryButton(2, 'Bàn phím', Icons.keyboard),
            _buildCategoryButton(3, 'Pad chuột', Icons.rectangle_rounded),
            _buildCategoryButton(4, 'Laptop', Icons.laptop),
            _buildCategoryButton(5, 'Tai nghe', Icons.headphones),
            _buildCategoryButton(6, 'Màn hình', Icons.monitor),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
      int categoryId, String categoryName, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = categoryId;
              });
              widget.onCategorySelected(categoryId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedCategory == categoryId
                  ? Theme.of(context).primaryColor
                  : Colors.orange[300],
              foregroundColor: _selectedCategory == categoryId
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              minimumSize: const Size(80, 80), // Adjust the size as needed
            ),
            child: Icon(icon, size: 25.0),
          ),
          const SizedBox(height: 8.0),
          Text(categoryName),
        ],
      ),
    );
  }
}
