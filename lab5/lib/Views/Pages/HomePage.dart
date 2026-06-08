import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Widgets/Product_Widget.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final List<Product> products;
  const Homepage({super.key, required this.products});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  // Danh sách các trang hiển thị trong body
  List<Widget> _buildPages() => [
        // Tab 0: Danh sách sản phẩm (dùng SingleChildScrollView để scroll)
        SingleChildScrollView(
          child: ReponsiveProduct(products: widget.products),
        ),
        // Tab 1: About
        const Center(
          child: Text(
            "About Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        title: const Text(
          "Product List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            icon: const Icon(Icons.account_box_outlined, color: Colors.white),
          ),
        ],
      ),
      body: _buildPages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "About",
          ),
        ],
      ),
    );
  }
}
