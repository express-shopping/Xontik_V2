import 'package:flutter/material.dart';

void main() {
  runApp(const XontikApp());
}

class XontikApp extends StatelessWidget {
  const XontikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      locale: const Locale('ar', 'AE'),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            _btn(Icons.phone_android, "الهاتف / البريد الإلكتروني"),
            _btn(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _btn(Icons.facebook, "المتابعة باستخدام Facebook"),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedScreen())),
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

  Widget _btn(IconData icon, String txt) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(5)),
      child: Row(children: [Icon(icon), Expanded(child: Text(txt, textAlign: TextAlign.center))]),
    );
  }
}

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
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
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
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              _avatar(),
              const SizedBox(height: 25),
              _action(liked ? Icons.favorite : Icons.favorite_border, "50K", liked ? Colors.red : Colors.white, () => setState(() => liked = !liked)),
              _action(Icons.comment, "1.2K", Colors.white, () {}),
              _action(Icons.share, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
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

  Widget _avatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(radius: 25, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
        if (!followed)
          Positioned(bottom: -8, left: 15, child: GestureDetector(onTap: () => setState(() => followed = true), child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20, color: Colors.white)))),
      ],
    );
  }

  Widget _action(IconData icon, String label, Color col, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Column(children: [Icon(icon, size: 38, color: col), Text(label, style: const TextStyle(fontSize: 12))])));
  }
}

