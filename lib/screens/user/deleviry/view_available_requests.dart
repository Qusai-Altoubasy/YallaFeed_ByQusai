import 'package:flutter/material.dart';

class Donation {
  final String name;
  final String qty;

  Donation({
    required this.name,
    required this.qty,
  });
}

class view_available_requests extends StatelessWidget {
  const view_available_requests({super.key});

  @override
  Widget build(BuildContext context) {
    final donations = [
      Donation(name: "Chicken Meal", qty: "3"),
      Donation(name: "Fresh Bread", qty: "10"),
      Donation(name: "Vegetables Box", qty: "4"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF5EC),
      appBar: AppBar(
        title: const Text(
          'Available Requests',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF388E3C),
        elevation: 0,
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
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ===== ICON / IMAGE =====
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF66BB6A),
                        Color(0xFF43A047),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.fastfood_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),

                const SizedBox(width: 16),

                // ===== DETAILS =====
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2E2E2E),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Persons: ${item.qty}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== ACTIONS =====
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_rounded,
                        color: Color(0xFF388E3C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43A047),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Accept'),
                    ),
                    const SizedBox(height: 4),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.redAccent,
                      ),
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
}
