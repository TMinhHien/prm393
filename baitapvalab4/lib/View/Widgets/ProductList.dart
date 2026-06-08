import 'package:flutter/material.dart';
import '../../Entities/Product.dart';
import 'ProductWidget.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  // Slider
  double sliderValue = 50;

  // Switch
  bool darkMode = false;

  // Radio
  String category = "Phone";

  // Date
  DateTime? selectedDate;

  List<Product> products = [
    Product(
      name: "iPhone 15",
      price: 1200,
      image:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx8YjJ5D4kU8bI3M4fF4Q2A0Q4gL5zG7Xn8A&s",
    ),
    Product(
      name: "Samsung S24",
      price: 1100,
      image:
      "https://images.samsung.com/is/image/samsung/p6pim/vn/2401/gallery/vn-galaxy-s24-s928-sm-s928bztqxxv-thumb-539573381",
    ),
  ];

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      home: Scaffold(
        appBar: AppBar(
          title: Text("Lab 4 Flutter UI"),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TEXT
                Text(
                  "Flutter UI Fundamentals",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // SLIDER
                Text(
                  "Slider Value: ${sliderValue.toInt()}",
                ),

                Slider(
                  value: sliderValue,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                // SWITCH
                SwitchListTile(
                  title: Text("Dark Mode"),
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),

                SizedBox(height: 20),

                // RADIO
                RadioListTile(
                  title: Text("Phone"),
                  value: "Phone",
                  groupValue: category,
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),

                RadioListTile(
                  title: Text("Laptop"),
                  value: "Laptop",
                  groupValue: category,
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // DATE PICKER
                ElevatedButton(
                  onPressed: pickDate,
                  child: Text("Pick Date"),
                ),

                SizedBox(height: 10),

                Text(
                  selectedDate == null
                      ? "No date selected"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),

                SizedBox(height: 20),

                // ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product List",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Icon(Icons.shop),
                  ],
                ),

                SizedBox(height: 20),

                // LISTVIEW FIX WITH SHRINKWRAP
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      product: products[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}