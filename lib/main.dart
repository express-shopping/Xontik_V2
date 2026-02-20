import 'package:flutter/material.dart';

void main() => runApp(const XontikFinalApp());

class XontikFinalApp extends StatelessWidget {
  const XontikFinalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      locale: const Locale('ar', 'AE'),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const TikTokLoginScreen(),
    );
  }
}

// --- واجهة تسجيل دخول احترافية ---
class TikTokLoginScreen extends StatelessWidget {
  const TikTokLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 4)),
            const SizedBox(height: 10),
            const Text("سجل دخولك لاستكشاف الإبداع", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 40),
            _authOption(Icons.phone_android, "الهاتف / البريد الإلكتروني"),
            _authOption(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _authOption(Icons.facebook, "المتابعة باستخدام Facebook"),
            const Spacer(),
            // زر إنشاء حساب صغير في الأسفل كما في تيك توك
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TikTokFeed())),
                    child: const Text("أنشئ حساباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _authOption(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(icon, size: 24),
          Expanded(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية ---
class TikTokFeed extends StatelessWidget {
  const TikTokFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) => VideoStack(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
        ],
      ),
    );
  }
}

class VideoStack extends StatefulWidget {
  final int index;
  const VideoStack({super.key, required this.index});

  @override
  State<VideoStack> createState() => _VideoStackState();
}

class _VideoStackState extends State<VideoStack> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black, child: const Center(child: Icon(Icons.play_arrow, size: 80, color: Colors.white10))),
        
        // الأزرار الجانبية بجهة اليسار وتتحرك مع كل فيديو
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              _profileAvatar(),
              const SizedBox(height: 25),
              _actionIcon(isLiked ? Icons.favorite : Icons.favorite_border, "50K", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked);
              }),
              _actionIcon(Icons.comment, "1.2K", Colors.white, () {}),
              _actionIcon(Icons.share, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
        
        // الوصف أسفل اليمين
        Positioned(
          right: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@user_xontik_${widget.index}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              const Text("التصميم النهائي الراقي بجهة اليسار 🚀"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(radius: 25, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
        if (!isFollowed)
          Positioned(
            bottom: -8, left: 15,
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

  Widget _actionIcon(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Icon(icon, size: 38, color: color),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

