import 'package:flutter/material.dart';

void main() => runApp(const XontikProApp());

class XontikProApp extends StatelessWidget {
  const XontikProApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const TikTokAuthPage(),
    );
  }
}

// --- شاشة الدخول الراقية ---
class TikTokAuthPage extends StatelessWidget {
  const TikTokAuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, letterSpacing: 5)),
            const SizedBox(height: 10),
            const Text("سجل دخولك لتجربة عالم الإبداع", style: TextStyle(color: Colors.white60, fontSize: 16)),
            const SizedBox(height: 60),
            _socialButton(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _socialButton(Icons.phone_iphone, "المتابعة باستخدام Apple"),
            _socialButton(Icons.mail_outline, "البريد الإلكتروني أو الهاتف"),
            const Spacer(),
            // زر إنشاء حساب صغير في الأسفل
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TikTokFeed())),
                child: RichText(
                  text: const TextSpan(
                    text: "ليس لديك حساب؟ ",
                    style: TextStyle(color: Colors.white54),
                    children: [
                      TextSpan(text: "أنشئ حساباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Icon(icon), Expanded(child: Text(label, textAlign: TextAlign.center))]),
  );
}

// --- شاشة الفيديوهات التفاعلية ---
class TikTokFeed extends StatelessWidget {
  const TikTokFeed({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => VideoPlayerItem(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'اكتشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف'),
        ],
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final int index;
  const VideoPlayerItem({super.key, required this.index});
  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // خلفية الفيديو (تأثير متدرج راقٍ)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[900]!, Colors.black],
            ),
          ),
          child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white10)),
        ),
        // الأزرار الجانبية على اليسار (تعمل بالضغط!)
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              _profileWithFollow(),
              const SizedBox(height: 25),
              _sideAction(isLiked ? Icons.favorite : Icons.favorite_border, "2.5M", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked); // القلب يعمل الآن!
              }),
              _sideAction(Icons.insert_comment, "1.2K", Colors.white, () {}),
              _sideAction(Icons.share, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
        // وصف الفيديو على اليمين
        Positioned(
          right: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@user_xontik_${widget.index}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              const Text("تصميم راقٍ ومميزات تيك توك كاملة 🚀"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileWithFollow() => Stack(
    clipBehavior: Clip.none,
    children: [
      const CircleAvatar(radius: 26, backgroundColor: Colors.white, child: CircleAvatar(radius: 24, backgroundColor: Colors.black, child: Icon(Icons.person))),
      if (!isFollowed)
        Positioned(
          bottom: -8, left: 16,
          child: GestureDetector(
            onTap: () => setState(() => isFollowed = true), // زر المتابعة يعمل!
            child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.add, size: 16, color: Colors.white)),
          ),
        ),
    ],
  );

  Widget _sideAction(IconData icon, String label, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(children: [Icon(icon, size: 38, color: color), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12))]),
    ),
  );
}

