import 'package:flutter/material.dart';

void main() => runApp(const XontikUltimate());

class XontikUltimate extends StatelessWidget {
  const XontikUltimate({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const LoginNavigator(), // البداية هنا
    );
  }
}

// محرك التنقل بين الصفحات
class LoginNavigator extends StatefulWidget {
  const LoginNavigator({super.key});
  @override
  State<LoginNavigator> createState() => _LoginNavigatorState();
}

class _LoginNavigatorState extends State<LoginNavigator> {
  bool showFeed = false; // متغير للتحكم في تبديل الصفحات

  @override
  Widget build(BuildContext context) {
    // إذا ضغط المستخدم على زر الدخول، تظهر صفحة الفيديوهات، وإلا تظهر صفحة الدخول
    return showFeed ? FeedScreen() : buildLoginScreen();
  }

  Widget buildLoginScreen() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text("XONTIK", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          const Text("سجل دخولك الآن", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 50),
          _authOption("المتابعة باستخدام Google"),
          _authOption("المتابعة باستخدام الهاتف"),
          const Spacer(),
          // زر "أنشئ حساباً" هو المحرك الذي يفتح التطبيق
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () => setState(() => showFeed = true), // هذا السطر يجعل الزر يعمل!
              child: const Text("ليس لديك حساب؟ أنشئ حساباً", 
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _authOption(String text) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(8)),
    child: Center(child: Text(text)),
  );
}

class FeedScreen extends StatelessWidget {
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
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
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black, child: Center(child: Text("فيديو رقم ${widget.index + 1}", style: const TextStyle(color: Colors.white12, fontSize: 30)))),
        
        // الأزرار بجهة اليسار
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              // زر المتابعة (+)
              _buildAvatar(),
              const SizedBox(height: 25),
              // زر القلب (اللايك)
              _buildAction(isLiked ? Icons.favorite : Icons.favorite_border, "25K", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked); // يجعل زر القلب يعمل!
              }),
              _buildAction(Icons.comment, "1.2K", Colors.white, () {}),
              _buildAction(Icons.share, "مشاركة", Colors.white, () {}),
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
        const CircleAvatar(radius: 25, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
        if (!isFollowed)
          Positioned(
            bottom: -5, left: 15,
            child: GestureDetector(
              onTap: () => setState(() => isFollowed = true), // يجعل زر المتابعة يعمل!
              child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.add, size: 15, color: Colors.white)),
            ),
          ),
      ],
    );
  }

  Widget _buildAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [Icon(icon, size: 38, color: color), Text(label, style: const TextStyle(fontSize: 12))]),
      ),
    );
  }
}

