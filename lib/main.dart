import 'package:flutter/material.dart';

void main() => runApp(const XontikProApp());

class XontikProApp extends StatelessWidget {
  const XontikProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      locale: const Locale('ar', 'AE'), // دعم اللغة العربية
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const AuthScreen(),
    );
  }
}

// --- واجهة تسجيل الدخول المتطورة ---
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, letterSpacing: 4)),
            const SizedBox(height: 50),
            _socialBtn(Icons.phone_android, "استخدام الهاتف / البريد الإلكتروني"),
            _socialBtn(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _socialBtn(Icons.facebook, "المتابعة باستخدام Facebook"),
            const Spacer(),
            // زر إنشاء حساب صغير في الأسفل كما في تيك توك
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedScreen())),
                    child: const Text("أنشئ حساباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialBtn(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Icon(icon, size: 22),
          Expanded(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية ---
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) => VideoItem(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 38), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف الشخصي'),
        ],
      ),
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
  bool liked = false;
  bool followed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black, child: const Center(child: Icon(Icons.play_arrow, size: 80, color: Colors.white10))),
        
        // الأزرار الجانبية (جهة اليسار وثابتة لكل فيديو)
        Positioned(
          left: 12,
          bottom: 100,
          child: Column(
            children: [
              _buildProfile(),
              const SizedBox(height: 20),
              _sideBtn(liked ? Icons.favorite : Icons.favorite_border, "500", liked ? Colors.red : Colors.white, () => setState(() => liked = !liked)),
              _sideBtn(Icons.insert_comment, "12", Colors.white, () {}),
              _sideBtn(Icons.reply, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
        
        // معلومات الفيديو (أسفل اليمين)
        Positioned(
          right: 15,
          bottom: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@user_xontik_${widget.index}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 7),
              const Text("تجربة التصميم النهائي الراقي 🚀", style: TextStyle(fontSize: 13)),
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
        const CircleAvatar(radius: 24, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
        if (!followed)
          Positioned(
            bottom: -7, left: 14,
            child: GestureDetector(
              onTap: () => setState(() => followed = true),
              child: Container(
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: const Icon(Icons.add, size: 18, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _sideBtn(IconData icon, String txt, Color col, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(icon, size: 35, color: col),
            const SizedBox(height: 3),
            Text(txt, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

