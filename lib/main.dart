import 'package:flutter/material.dart';

void main() => runApp(const XontikUltimateApp());

class XontikUltimateApp extends StatelessWidget {
  const XontikUltimateApp({super.key});

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

// --- واجهة تسجيل دخول احترافية ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, letterSpacing: 4)),
            const SizedBox(height: 10),
            const Text("سجل دخولك لمتابعة الإبداع", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 40),
            _authButton(Icons.person_outline, "استخدام الهاتف / البريد الإلكتروني"),
            _authButton(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _authButton(Icons.facebook, "المتابعة باستخدام Facebook"),
            const Spacer(),
            // زر إنشاء حساب صغير في الأسفل
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainFeed())),
                    child: const Text("إنشاء حساب", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _authButton(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(icon, size: 24),
          Expanded(child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية ---
class MainFeed extends StatelessWidget {
  const MainFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) => VideoPlaceholder(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
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

class VideoPlaceholder extends StatefulWidget {
  final int index;
  const VideoPlaceholder({super.key, required this.index});

  @override
  State<VideoPlaceholder> createState() => _VideoPlaceholderState();
}

class _VideoPlaceholderState extends State<VideoPlaceholder> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white.withOpacity(0.2))),
        ),
        // الأزرار الجانبية بجهة اليسار - تتحرك مع كل فيديو
        Positioned(
          left: 15,
          bottom: 100,
          child: Column(
            children: [
              _buildAvatar(),
              const SizedBox(height: 20),
              _sideAction(isLiked ? Icons.favorite : Icons.favorite_border, "250K", isLiked ? Colors.red : Colors.white, () {
                setState(() => isLiked = !isLiked);
              }),
              _sideAction(Icons.comment, "1.2K", Colors.white, () {}),
              _sideAction(Icons.share, "مشاركة", Colors.white, () {}),
            ],
          ),
        ),
        // وصف الفيديو
        Positioned(
          right: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@user_xontik_${widget.index}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              const Text("هذا الفيديو رقم ${widget.index} - استمتع بالتجربة 🚀"),
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

  Widget _sideAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(icon, size: 35, color: color),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

