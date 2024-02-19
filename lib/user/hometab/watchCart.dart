import 'package:flutter/material.dart';

class WatchCart extends StatefulWidget {
  const WatchCart({super.key});

  @override
  State<WatchCart> createState() => _WatchCartState();
}

class _WatchCartState extends State<WatchCart> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image side
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      "assets/images/model2.png",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Details side
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Watch 1",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Price: \$200",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Add to cart logic here
                            },
                            child: Text("Add to Cart"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
