import 'package:flutter/material.dart';

void main() => runApp(const XontikApp());

class XontikApp extends StatelessWidget {
  const XontikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TikTokScreen(),
    );
  }
}

class TikTokScreen extends StatelessWidget {
  const TikTokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة ألوان لمحاكاة خلفيات الفيديو لضمان خفة التطبيق
    final List<Color> videoPlaceholders = [
      Colors.black,
      Colors.blueGrey[900]!,
      Colors.black87,
      Colors.indigo[900]!,
    ];

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical, // التمرير الرأسي مثل تيك توك
        itemCount: videoPlaceholders.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // خلفية الفيديو
              Container(color: videoPlaceholders[index]),
              const Center(
                child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white24),
              ),
              
              // الأزرار الجانبية للتفاعل
              Positioned(
                right: 15,
                bottom: 100,
                child: Column(
                  children: [
                    _buildIcon(Icons.favorite, "2.5K", Colors.red),
                    _buildIcon(Icons.comment, "120", Colors.white),
                    _buildIcon(Icons.share, "Share", Colors.white),
                  ],
                ),
              ),
              
              // معلومات المستخدم ووصف الفيديو
              Positioned(
                left: 15,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "@Xontik_Creator",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Welcome to Xontik! Enjoy the flow. 🚀",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // ويدجت بناء الأزرار الجانبية
  Widget _buildIcon(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(icon, size: 38, color: color),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
