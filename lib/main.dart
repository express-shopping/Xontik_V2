import 'package:flutter/material.dart';

void main() => runApp(const XontikPro());

class XontikPro extends StatelessWidget {
  const XontikPro({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'AE'),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const Text("XONTIK", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, letterSpacing: 3)),
          const SizedBox(height: 50),
          _authBtn("الهاتف / البريد الإلكتروني"),
          _authBtn("المتابعة باستخدام Google"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedView())),
              child: const Text("أنشئ حساباً (اضغط هنا للدخول)", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _authBtn(String t) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(8)),
    child: Center(child: Text(t, style: const TextStyle(fontSize: 14))),
  );
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (context, index) => VideoStack(i: index),
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
  final int i;
  const VideoStack({super.key, required this.i});
  @override
  State<VideoStack> createState() => _VideoStackState();
}

class _VideoStackState extends State<VideoStack> {
  bool liked = false;
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black, child: const Center(child: Icon(Icons.play_arrow, size: 80, color: Colors.white10))),
        // الأزرار الجانبية بجهة اليسار (تتحرك مع كل فيديو)
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
        // الوصف بجهة اليمين
        Positioned(
          right: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@user_xontik_${widget.i}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              const Text("تصميم راقٍ بجهة اليسار 🚀", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
  Widget _avatar() => Stack(
    clipBehavior: Clip.none,
    children: [
      const CircleAvatar(radius: 26, backgroundColor: Colors.white, child: CircleAvatar(radius: 24, backgroundColor: Colors.black, child: Icon(Icons.person))),
      if (!follow) Positioned(bottom: -8, left: 16, child: GestureDetector(onTap: () => setState(() => follow = true), child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.add, size: 15, color: Colors.white)))),
    ],
  );
  Widget _action(IconData i, String l, Color c, VoidCallback o) => GestureDetector(onTap: o, child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [Icon(i, size: 38, color: c), const SizedBox(height: 5), Text(l, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))])));
}

