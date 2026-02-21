import 'package:flutter/material.dart';

void main() => runApp(const XontikMasterpiece());

class XontikMasterpiece extends StatelessWidget {
  const XontikMasterpiece({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

// --- 1. واجهة تسجيل الدخول ---
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold, letterSpacing: 6)),
            const SizedBox(height: 10),
            const Text("انضم إلى مجتمع المبدعين العالمي", style: TextStyle(color: Colors.white54, fontSize: 15)),
            const SizedBox(height: 60),
            _socialBtn(Icons.person_outline, "استخدام الهاتف / البريد الإلكتروني"),
            _socialBtn(Icons.facebook, "المتابعة باستخدام Facebook", color: Colors.blueAccent),
            _socialBtn(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _socialBtn(Icons.apple, "المتابعة باستخدام Apple"),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const MainTikTokScaffold())),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: RichText(text: const TextSpan(text: "ليس لديك حساب؟ ", style: TextStyle(color: Colors.white60), children: [
                  TextSpan(text: "إنشاء حساب", style: TextStyle(color: Color(0xFFeb3349), fontWeight: FontWeight.bold)),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _socialBtn(IconData icon, String label, {Color color = Colors.white}) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white12, width: 1)),
    child: Row(children: [Icon(icon, color: color, size: 26), Expanded(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)))]),
  );
}

// --- 2. الهيكل الرئيسي مع زر النشر المطور ---
class MainTikTokScaffold extends StatefulWidget {
  const MainTikTokScaffold({super.key});
  @override
  State<MainTikTokScaffold> createState() => _MainTikTokScaffoldState();
}

class _MainTikTokScaffoldState extends State<MainTikTokScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const TikTokFeedView(), const Center(child: Text("اكتشف")), Container(), const Center(child: Text("الرسائل")), const ProfileScreen()];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showUploadOptions(context);
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(icon: _buildPlusIcon(), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'صندوق الوارد'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف'),
        ],
      ),
    );
  }

  Widget _buildPlusIcon() => SizedBox(width: 45, height: 28, child: Stack(children: [
    Container(margin: const EdgeInsets.only(left: 10), width: 38, decoration: BoxDecoration(color: const Color(0xFF2af1f7), borderRadius: BorderRadius.circular(7))),
    Container(margin: const EdgeInsets.only(right: 10), width: 38, decoration: BoxDecoration(color: const Color(0xFFeb3349), borderRadius: BorderRadius.circular(7))),
    Center(child: Container(width: 38, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)), child: const Icon(Icons.add, color: Colors.black, size: 20))),
  ]));

  void _showUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _uploadBtn(Icons.videocam, "كاميرا", Colors.purple),
              _uploadBtn(Icons.image, "صور", Colors.blue),
              _uploadBtn(Icons.upload_file, "رفع فيديو", Colors.redAccent),
            ]),
            const Spacer(),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء", style: TextStyle(color: Colors.white, fontSize: 16)))
          ],
        ),
      ),
    );
  }
  Widget _uploadBtn(IconData i, String t, Color c) => Column(children: [CircleAvatar(radius: 30, backgroundColor: c.withOpacity(0.2), child: Icon(i, color: c, size: 30)), const SizedBox(height: 10), Text(t)]);
}

// --- 3. الملف الشخصي (أزرار دائرية ووردية) ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("Xontik_Creator"), centerTitle: true, actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})]),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 15),
          const Text("@xontik_official", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_stat("150", "أتابع"), _stat("1.5M", "متابعين"), _stat("10M", "إعجاب")]),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _profileActionBtn("تعديل الملف", const Color(0xFFeb3349), () => Navigator.push(context, MaterialPageRoute(builder: (c) => const EditProfileScreen()))),
            const SizedBox(width: 10),
            _profileActionBtn("مشاركة الملف", Colors.white10, () => _showShareMenu(context)),
          ]),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1), itemCount: 12, itemBuilder: (c, i) => Container(color: Colors.white10, child: const Icon(Icons.play_arrow, color: Colors.white24)))),
        ],
      ),
    );
  }
  Widget _stat(String v, String l) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.grey))]));
  Widget _profileActionBtn(String t, Color c, VoidCallback o) => GestureDetector(onTap: o, child: Container(padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(25)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))));
  
  void _showShareMenu(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.grey[900], builder: (c) => Container(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [const Text("مشاركة الملف الشخصي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 20), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [Icon(Icons.link, size: 40), Icon(Icons.facebook, size: 40), Icon(Icons.send, size: 40)])])));
  }
}

// --- 4. محرك الفيديوهات التفاعلي (إعادة الأزرار المفقودة) ---
class TikTokFeedView extends StatelessWidget {
  const TikTokFeedView({super.key});
  @override
  Widget build(BuildContext context) => PageView.builder(scrollDirection: Axis.vertical, itemBuilder: (context, index) => const VideoItem());
}

class VideoItem extends StatelessWidget {
  const VideoItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blueGrey, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
      
      // الأزرار التفاعلية الجانبية (إعادة المفقود)
      Positioned(right: 10, bottom: 100, child: Column(children: [
        _sideProfile(),
        const SizedBox(height: 20),
        _sideAction(Icons.favorite, "5.2M", Colors.red),
        _sideAction(Icons.chat_bubble, "15K", Colors.white),
        _sideAction(Icons.bookmark, "90K", Colors.amber),
        _sideAction(Icons.share, "مشاركة", Colors.white),
        const SizedBox(height: 25),
        _musicRotationIcon(), // الدائرة المتحركة
      ])),

      // معلومات الفيديو (إعادة الصوت الأصلي)
      Positioned(left: 15, bottom: 25, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("@Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        const Text("تجربة واجهة إكسونتيك الجديدة كلياً 🔥"),
        const SizedBox(height: 12),
        Row(children: const [Icon(Icons.music_note, size: 16), SizedBox(width: 5), Text("الصوت الأصلي - Xontik Pro")]),
      ])),
    ]);
  }

  Widget _sideProfile() => Stack(clipBehavior: Clip.none, children: [
    const CircleAvatar(radius: 25, backgroundColor: Colors.white, child: CircleAvatar(radius: 23, child: Icon(Icons.person))),
    Positioned(bottom: -10, left: 15, child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20)))
  ]);

  Widget _sideAction(IconData i, String l, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [Icon(i, size: 35, color: c), Text(l, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]));

  Widget _musicRotationIcon() => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: SweepGradient(colors: [Colors.black, Colors.grey[800]!, Colors.black])),
    child: const Icon(Icons.music_note, size: 20, color: Colors.white),
  );
}

// --- واجهة تعديل الملف ---
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("تعديل الملف")), body: const Center(child: Text("واجهة التعديل")));
  }
}

