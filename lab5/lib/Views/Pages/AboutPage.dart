import 'package:flutter/material.dart';
import 'package:exam/Views/Widgets/ButtonBar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "About Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade100)),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width < 700 ? 1 : 2,
            children: const [
              Card(child: Center(child: Text("Thông tin 1"))),
              Card(child: Center(child: Text("Thông tin 2"))),
              Card(child: Center(child: Text("Thông tin 3"))),
              Card(child: Center(child: Text("Thông tin 4"))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Buttonbar(),
    );
  }
}
