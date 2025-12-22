import 'package:flutter/material.dart';
import 'package:qusai/shared/shared.dart';
import 'donatin_details.dart';

class Donation {
  final String name;
  final String qty;

  Donation({
    required this.name,
    required this.qty,
  });
}

class view_available_donation extends StatelessWidget {
  const view_available_donation({super.key});

  @override
  Widget build(BuildContext context) {
    final donations = [
      Donation(name: "Chicken Meal", qty: "3"),
      Donation(name: "Fresh Bread", qty: "10"),
      Donation(name: "Vegetables Box", qty: "4"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF6A1B9A)),
        title: const Text(
          'Available Donations',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final item = donations[index];

          return Card(
            elevation: 6,
            shadowColor: Colors.black12,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // ===== ICON =====
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A1B9A).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.fastfood_outlined,
                      size: 32,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // ===== INFO =====
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Serves ${item.qty} people',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== ACTIONS =====
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined,
                            color: Color(0xFF6A1B9A)),
                        tooltip: 'View details',
                        onPressed: () {
                          navigatetoWithTransition(
                            context,
                            donation_detalis(),
                            color: const Color(0xFF5C6BC0),
                            message: 'Loading donation details...',
                          );

                        },
                      ),
                      TextButton(
                        onPressed: () {
                          // accept donation
                        },
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent),
                    tooltip: 'Reject',
                    onPressed: () {
                      // reject donation
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
