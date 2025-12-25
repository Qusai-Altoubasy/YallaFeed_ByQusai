import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qusai/classes/announcement.dart';
import 'package:qusai/screens/common_screens/showannouncement.dart';
import 'package:qusai/shared/shared.dart';

class announcemnts_shared extends StatefulWidget {
  @override
  State<announcemnts_shared> createState() => _announcemnts_sharedState();
}

class _announcemnts_sharedState extends State<announcemnts_shared> {
  List<String> readIds = [];
  bool loading = true;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadReadAnnouncements();
  }

  Future<void> loadReadAnnouncements() async {
    final readSnapshot = await FirebaseFirestore.instance
        .collection('read_announcements')
        .where('userId', isEqualTo: userid)
        .get();

    readIds =
        readSnapshot.docs.map((e) => e['announcementId'] as String).toList();

    setState(() => loading = false);
  }


  Query _announcementQuery() {
    final base = FirebaseFirestore.instance
        .collection('announcements')
        .orderBy('time', descending: true);

    if (usertype == 'admin') {
      return base;
    } else if (usertype == 'user') {
      return base.where('sendto', isEqualTo: 'users');
    } else {
      return base.where('sendto', isEqualTo: 'charities');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE8EEF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Announcements',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Color(0xFF0F172A),
                  size: 28,
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints:
                      const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9BE7FF),
              Color(0xFFB3E5FC),
              Color(0xFFE1F5FE),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder(
          stream: _announcementQuery().snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs
                .where((doc) => !readIds.contains(doc.id))
                .toList();

            unreadCount = docs.length;

            if (docs.isEmpty) {
              return const Center(
                child: Text(
                  'No new announcements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
              itemCount: docs.length,
              itemBuilder: (context, index) =>
                  _announcementCard(context, docs[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _announcementCard(
      BuildContext context, QueryDocumentSnapshot doc) {
    final String target = doc['sendto'];

    return GestureDetector(
      onTap: () async {
        final model = announcement(
          title: doc['title'],
          message: doc['message'],
          sendTo: doc['sendto'],
          owener: doc['owener'],
          id: doc.id,
        );

        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => show_announecement(current: model),
          ),
        );

        if (result != null) {
          setState(() => readIds.add(result));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: target == 'users'
                      ? [Color(0xFF42A5F5), Color(0xFF64B5F6)]
                      :target == 'admin'?[Color(0xFFEF5350), Color(0xFFEF9A9A)]:
                  [Color(0xFF66BB6A), Color(0xFF81C784)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.campaign_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: target == 'users'
                              ? Colors.blue.withOpacity(0.15)
                              :target == 'admin'?Colors.red.withOpacity(0.15):
                          Colors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          target == 'users' ? 'User' :target == 'admin'?'admin': 'Charity',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: target == 'users'
                                ? Colors.blue
                                :
                            target == 'admin'?Colors.red:
                            Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
