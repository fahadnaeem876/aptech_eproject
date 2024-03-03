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
              return _buildBrandCard(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(int index) {
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

    List<String> brandImages = [
      "https://i.pinimg.com/736x/55/5d/17/555d175e18c7d1b0bad9594a06fd7872.jpg", // Sample online image address
      "https://lh3.googleusercontent.com/proxy/jGRRayETKIG9IVVyVFijikPxwS5erA24rjd7NDgEYPoQSkVc9dbKv2E-YsRlN28iVLk-oHgT0CZWHeW_7mDoXYAIZh2K4oSMsck8t5LoE2U",
      "https://www.tagheuer.com/on/demandware.static/-/Library-Sites-TagHeuer-Shared/default/dwc4e18db9/images/Events/Watches-and-wonders-2023/carrera-glassbox-blue-tag-heuer.png",
      "https://iwc.com.pk/wp-content/uploads/2023/09/snkf67j1.jpg",
      "https://www.zamana.pk/cdn/shop/products/image_32.png?v=1692271707",
      "https://iwc.com.pk/wp-content/uploads/2021/06/TW2T50500-1.jpg",
      "https://iwc.com.pk/wp-content/uploads/2023/08/T116.617.11.037.00.jpg",
      "https://brandedwatches.pk/wp-content/uploads/2022/10/Fossil-FS5230-Mens-Chronograph-Quartz-Stainless-Steel-Blue-Dial-44mm-Watch-copy.jpg",
      "https://www.lifestyle-collection.com.pk/wp-content/uploads/2020/10/GA-900A-1A9DR-1.jpg",
      "https://7star.pk/wp-content/uploads/2022/06/Citizen16.jpg",
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
            Image.network(
              brandImages[index % brandImages.length],
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
