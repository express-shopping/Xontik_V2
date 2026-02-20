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
          const Text("XONTIK", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          _authBtn("الهاتف / البريد الإلكتروني"),
          _authBtn("المتابعة باستخدام Google"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedView())),
              child: const Text("أنشئ حساباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _authBtn(String t) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(5)),
    child: Center(child: Text(t)),
  );
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => VideoStack(i: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
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
        // الأزرار الجانبية بجهة اليسار
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              _avatar(),
              const SizedBox(height: 25),
              _action(liked ? Icons.favorite : Icons.favorite_border, "50K", liked ? Colors.red : Colors.white, () => setState(() => liked = !liked)),
              _action(Icons.comment, "1.2K", Colors.white, () {}),
            ],
          ),
        ),
        Positioned(right: 15, bottom: 30, child: Text("@user_xontik_${widget.i}", style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }
  Widget _avatar() => Stack(
    clipBehavior: Clip.none,
    children: [
      const CircleAvatar(radius: 25, child: Icon(Icons.person)),
      if (!follow) Positioned(bottom: -5, left: 15, child: GestureDetector(onTap: () => setState(() => follow = true), child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.add, size: 15)))),
    ],
  );
  Widget _action(IconData i, String l, Color c, VoidCallback o) => GestureDetector(onTap: o, child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [Icon(i, size: 35, color: c), Text(l, style: const TextStyle(fontSize: 10))])));
}

