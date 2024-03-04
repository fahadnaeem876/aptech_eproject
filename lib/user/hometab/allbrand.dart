import 'package:flutter/material.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Brands'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: List.generate(
            10, // Assuming you have 10 brands, you can replace this with your actual brand list length
            (index) {
              return _buildBrandCard(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(BuildContext context, int index) {
    // Dummy brand names, replace these with your actual brand data
    List<String> brandNames = [
      "Rolex",
      "Omega",
      "TAG Heuer",
      "Seiko",
      "Casio",
      "Timex",
      "Tissot",
      "Fossil",
      "G-Shock",
      "Citizen",
    ];

    List<String> brandImagePaths = [
      "assets/images/brandimg1.jpg",
      "assets/images/brandimg2.jpg",
      "assets/images/brandimg3.png",
      "assets/images/brandimg4.jpg",
      "assets/images/brandimg5.png",
      "assets/images/brandimg6.jpg",
      "assets/images/brandimg7.jpg",
      "assets/images/brandimg8.png",
      "assets/images/brandimg9.jpg",
      "assets/images/brandimg10.jpg",
    ];

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle brand tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              brandImagePaths[index % brandImagePaths.length],
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.0),
            Text(
              brandNames[index % brandNames.length],
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
