import 'package:flutter/material.dart';

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
      Donation(name: "Chicken Meal", qty: "3"),
      Donation(name: "Fresh Bread", qty: "10"),
      Donation(name: "Vegetables Box", qty: "4"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final item = donations[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon / Image placeholder
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6FB1FC), Color(0xFF4A90E2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.fastfood_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Serves ${item.qty} people",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Actions
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_outlined),
                      color: Colors.blueGrey,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.redAccent,
                    ),
                    IconButton(
                      onPressed: () {
                        _showRatingDialog(context, item.name);
                      },
                      icon: const Icon(Icons.star_border, color: Colors.amber, size: 30),
                      tooltip: 'Rate Order',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  void _showRatingDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        int selectedStars = 0; // متغير لحفظ عدد النجوم المختار

        // StatefulBuilder ضروري عشان نقدر نغير لون النجوم بنفس اللحظة
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(child: Text("Rate $itemName")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("How was the quality?", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),

                  // رسم النجوم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          // تحديث الحالة عند الضغط
                          setState(() {
                            selectedStars = index + 1;
                          });
                        },
                        // تغيير الأيقونة واللون بناءً على الاختيار
                        icon: Icon(
                          index < selectedStars ? Icons.star : Icons.star_border,
                          color: index < selectedStars ? Colors.amber : Colors.grey,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // هنا بتكتب كود الحفظ (Backend)
                    Navigator.pop(context);

                    // رسالة تأكيد صغيرة
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You rated $selectedStars stars for $itemName!")),
                    );
                  },
                  child: const Text("Submit"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
