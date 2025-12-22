import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/classes/mainuser.dart';

class AnnouncementDesign extends StatelessWidget {
  final mainuser Owenr;
  final String uid;

  AnnouncementDesign({required this.Owenr, required this.uid});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final messageController = TextEditingController();
    String? selectedGroup;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2F855A),
              Color(0xFF68D391),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ===== HEADER =====
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1F7A5C),
                                Color(0xFF3AA17E),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                                onPressed: () =>
                                    Navigator.pop(context),
                              ),
                              const SizedBox(height: 12),
                              const Icon(Icons.campaign,
                                  color: Colors.white, size: 40),
                              const SizedBox(height: 14),
                              const Text(
                                'Send Announcement',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Broadcast important messages to your community',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),

                        // ===== FORM CARD =====
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // TITLE
                                TextFormField(
                                  controller: titleController,
                                  validator: (v) => v!.isEmpty
                                      ? 'Title is required'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Announcement Title',
                                    prefixIcon:
                                    const Icon(Icons.title),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // MESSAGE
                                TextFormField(
                                  controller: messageController,
                                  validator: (v) => v!.isEmpty
                                      ? 'Message is required'
                                      : null,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    labelText: 'Message Content',
                                    alignLabelWithHint: true,
                                    prefixIcon: const Icon(
                                        Icons.message_outlined),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // DROPDOWN
                                DropdownButtonFormField<String>(
                                  validator: (v) => v == null
                                      ? 'Select target group'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Send To',
                                    prefixIcon: const Icon(
                                        Icons.group_outlined),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'users',
                                      child: Text('All Users'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'charities',
                                      child: Text('All Charities'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    selectedGroup = v;
                                  },
                                ),

                                const SizedBox(height: 36),

                                // ===== BUTTON =====
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.send),
                                    label: const Text(
                                      'Send Announcement',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style:
                                    ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF1F7A5C),
                                      elevation: 8,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            22),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (!formKey.currentState!
                                          .validate()) return;

                                      final A = announcement(
                                        title:
                                        titleController.text,
                                        message:
                                        messageController.text,
                                        sendTo: selectedGroup!,
                                        owener: uid,
                                        id: 'temp',
                                      );

                                      try {
                                        A.svaeindatabase();
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Announcement sent successfully'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      } catch (_) {}
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
