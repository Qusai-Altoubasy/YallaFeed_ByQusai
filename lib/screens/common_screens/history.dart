import 'package:flutter/material.dart';
import 'package:qusai/components/components.dart';

class Donation {
  final String name;
  final String qty;


  Donation({
    required this.name,
    required this.qty,

  });
}

class history extends StatelessWidget {
  const history({super.key});

  @override
  Widget build(BuildContext context) {
    final donations = [
      Donation(
        name: "Chicken Meal",
        qty: "3",
      ),
      Donation(
        name: "Fresh Bread",
        qty: "10",
      ),
      Donation(
        name: "Vegetables Box",
        qty: "4",
      )
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final item = donations[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image Placeholder
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.fastfood, size: 35),
                  ),
                  const SizedBox(width: 15),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("Persons: ${item.qty}"),
                        const SizedBox(height: 6),

                      ],
                    ),
                  ),
                  // Buttons
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility)),

                      SizedBox(height: 5,),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.red)),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}