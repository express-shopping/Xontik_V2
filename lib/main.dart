import 'package:flutter/material.dart';

void main() {
  runApp(const XontikFinalApp());
}

class XontikFinalApp extends StatelessWidget {
  const XontikFinalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      locale: const Locale('ar', 'AE'),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TikTokAuthScreen(),
    );
  }
}

// --- شاشة تسجيل الدخول الاحترافية ---
class TikTokAuthScreen extends StatelessWidget {
  const TikTokAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 5, color: Colors.white)),
            const SizedBox(height: 10),
            const Text("سجل دخولك لاستكشاف الفيديوهات", style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 50),
            _buildLoginOption(Icons.phone_android, "استخدام الهاتف أو البريد"),
            _buildLoginOption(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _buildLoginOption(Icons.facebook, "المتابعة باستخدام Facebook"),
            _buildLoginOption(Icons.apple, "المتابعة باستخدام Apple"),
            const Spacer(),
            // زر إنشاء حساب صغير وأنيق في الأسفل
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TikTokHome())),
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

  Widget _buildLoginOption(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          Expanded(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية (نسخة تيك توك الأصلية) ---
class TikTokHome extends StatelessWidget {
  const TikTokHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) => VideoContent(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'اكتشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'صندوق الوارد'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف الشخصي'),
        ],
      ),
    );
  }
}

class VideoContent extends StatefulWidget {
  final int index;
  const VideoContent({super.key, required this.index});

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // مكان الفيديو
        Container(color: Colors.black, child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white12))),
        
        // الأزرار الجانبية على اليسار (تتحرك مع كل فيديو)
        Positioned(
          left: 15, // جهة اليسار كما طلبت
          bottom: 100,
          child: Column(
            children: [
              _buildAvatar(),
              const SizedBox(height: 25),
              _buildSideAction(isLiked ? Icons.favorite : Icons.favorite_border, "2.5M", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked);
              }),
              _buildSideAction(Icons.comment, "15.4K", Colors.white, () {}),
              _buildSideAction(Icons.share, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
        
        // معلومات صاحب الفيديو والوصف (أسفل اليمين)
        Positioned(
          right: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@creator_xontik_${widget.index}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
              const SizedBox(height: 10),
              const Text("تجربة النسخة النهائية من XONTIK 🚀 #فلوتر", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const CircleAvatar(radius: 25, backgroundColor: Colors.black, child: Icon(Icons.person, color: Colors.white)),
        ),
        if (!isFollowed)
          Positioned(
            bottom: -8,
            left: 15,
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Icon(icon, size: 38, color: color),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

