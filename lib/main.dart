import 'package:flutter/material.dart';

void main() => runApp(const XontikMasterpiece());

class XontikMasterpiece extends StatelessWidget {
  const XontikMasterpiece({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainTikTokScaffold(),
    );
  }
}

class MainTikTokScaffold extends StatefulWidget {
  const MainTikTokScaffold({super.key});
  @override
  State<MainTikTokScaffold> createState() => _MainTikTokScaffoldState();
}

class _MainTikTokScaffoldState extends State<MainTikTokScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const TikTokFeedView(), // شاشة الفيديوهات الرئيسية
          const Center(child: Text("اكتشف الصيحات الجديدة")),
          const Center(child: Text("الكاميرا قيد التطوير")),
          const Center(child: Text("صندوق الوارد فارغ")),
          const Center(child: Text("الملف الشخصي الاحترافي")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(icon: _buildPlusIcon(), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'صندوق الوارد'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف'),
        ],
      ),
    );
  }

  Widget _buildPlusIcon() {
    return SizedBox(
      width: 45,
      height: 28,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(color: const Color(0xFF2af1f7), borderRadius: BorderRadius.circular(7)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(color: const Color(0xFFeb3349), borderRadius: BorderRadius.circular(7)),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// --- محرك الفيديوهات (TikTok Style) ---
class TikTokFeedView extends StatelessWidget {
  const TikTokFeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => VideoItem(index: index),
    );
  }
}

class VideoItem extends StatefulWidget {
  final int index;
  const VideoItem({super.key, required this.index});
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // محاكاة الفيديو مع تدرج لوني فخم
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey[900]!, Colors.black],
            ),
          ),
          child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white12)),
        ),
        
        // الجزء العلوي: For You & Following
        const Positioned(
          top: 40,
          left: 0, right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("أتابع", style: TextStyle(color: Colors.white54, fontSize: 16)),
              SizedBox(width: 20),
              Text("لك", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.circle, size: 5, color: Colors.white),
            ],
          ),
        ),

        // الأزرار التفاعلية بجهة اليسار (TikTok Layout)
        Positioned(
          left: 10,
          bottom: 100,
          child: Column(
            children: [
              _buildProfile(),
              const SizedBox(height: 20),
              _buildSideAction(isLiked ? Icons.favorite : Icons.favorite_border, "5.2M", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked);
              }),
              _buildSideAction(Icons.chat_bubble, "15.4K", Colors.white, () {}),
              _buildSideAction(Icons.bookmark, "90K", Colors.white, () {}),
              _buildSideAction(Icons.share, "مشاركة", Colors.white, () {}),
              const SizedBox(height: 20),
              _buildMusicDisc(), // أسطوانة الموسيقى الدوارة
            ],
          ),
        ),

        // وصف الفيديو والمعلومات بجهة اليمين
        Positioned(
          right: 15,
          bottom: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("@Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              const SizedBox(height: 10),
              const SizedBox(
                width: 250,
                child: Text("هذه هي النسخة القاضية من تطبيق XONTIK.. إبداع بلا حدود! 🔥 #فلوتر #تيكتوك", 
                style: TextStyle(color: Colors.white, fontSize: 14), overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.music_note, size: 15, color: Colors.white),
                  SizedBox(width: 5),
                  Text("الصوت الأصلي - مبرمج Xontik", style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const CircleAvatar(radius: 24, backgroundColor: Colors.black, child: Icon(Icons.person, color: Colors.white)),
        ),
        if (!isFollowed)
          Positioned(
            bottom: -8, left: 14,
            child: GestureDetector(
              onTap: () => setState(() => isFollowed = true),
              child: Container(
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: const Icon(Icons.add, size: 20, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSideAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(icon, size: 35, color: color),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicDisc() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: SweepGradient(colors: [Colors.grey[800]!, Colors.black, Colors.grey[800]!]),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 8),
      ),
      child: const Icon(Icons.music_note, size: 20, color: Colors.white),
    );
  }
}

