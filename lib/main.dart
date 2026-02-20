import 'package:flutter/material.dart';

void main() => runApp(const XontikUltimateApp());

class XontikUltimateApp extends StatelessWidget {
  const XontikUltimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      // دعم اللغة العربية بشكل صحيح
      locale: const Locale('ar', 'AE'),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.redAccent,
      ),
      home: const LoginScreen(),
    );
  }
}

// --- واجهة تسجيل دخول مطورة ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.withOpacity(0.1), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "XONTIK",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.black,
                  letterSpacing: 8,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text("سجل دخولك لمتابعة الإبداع", 
                style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 50),
              
              _authButton(Icons.person_outline, "استخدام الهاتف / البريد الإلكتروني", () {}),
              _authButton(Icons.g_mobiledata, "المتابعة باستخدام Google", () {}),
              _authButton(Icons.facebook, "المتابعة باستخدام Facebook", () {}),
              
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("ليس لديك حساب؟", style: TextStyle(color: Colors.white54)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainFeed()),
                        );
                      },
                      child: const Text("إنشاء حساب", 
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _authButton(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية ---
class MainFeed extends StatefulWidget {
  const MainFeed({super.key});

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) => VideoPlaceholder(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, size: 35, color: Colors.white), 
            label: ''
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف'),
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
    // استخدام Directionality لضمان ثبات العناصر مهما كانت لغة الجهاز
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // محاكي لمشغل الفيديو
          Container(
            color: Colors.black,
            child: Center(
              child: Icon(Icons.play_arrow_rounded, 
                size: 100, color: Colors.white.withOpacity(0.1)),
            ),
          ),
          
          // التدرج الأسود في الأسفل لجعل النص واضحاً
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),

          // الأزرار الجانبية (في جهة اليسار)
          Positioned(
            left: 10,
            bottom: 100,
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: 25),
                _sideAction(
                  isLiked ? Icons.favorite : Icons.favorite, 
                  "250K", 
                  isLiked ? Colors.red : Colors.white, 
                  () => setState(() => isLiked = !isLiked)
                ),
                _sideAction(Icons.comment_rounded, "1.2K", Colors.white, () {}),
                _sideAction(Icons.share_rounded, "مشاركة", Colors.white, () {}),
              ],
            ),
          ),

          // وصف الفيديو (في جهة اليمين)
          Positioned(
            right: 15,
            bottom: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@user_xontik_${widget.index}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    "هذا الفيديو رقم ${widget.index} المصمم لمجتمع XONTIK الرائع! #إبداع #فلاتر",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        if (!isFollowed)
          Positioned(
            bottom: -10,
            child: GestureDetector(
              onTap: () => setState(() => isFollowed = true),
              child: Container(
                decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                child: const Icon(Icons.add, size: 20, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _sideAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 38, color: color),
        ),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
      ],
    );
  }
}

