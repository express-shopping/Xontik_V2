import 'package:flutter/material.dart';

void main() => runApp(const XontikSuperApp());

class XontikSuperApp extends StatelessWidget {
  const XontikSuperApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const AuthScreen(),
    );
  }
}

// --- 1. واجهة تسجيل الدخول وإنشاء الحساب ---
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, letterSpacing: 5)),
            const SizedBox(height: 50),
            _authBtn(Icons.facebook, "المتابعة باستخدام Facebook", Colors.blue),
            _authBtn(Icons.g_mobiledata, "المتابعة باستخدام Google", Colors.white10),
            _authBtn(Icons.apple, "المتابعة باستخدام Apple", Colors.white10),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainNavigation())),
              child: RichText(text: const TextSpan(text: "ليس لديك حساب؟ ", children: [TextSpan(text: "أنشئ حساباً", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))])),
            ),
          ],
        ),
      ),
    );
  }
  Widget _authBtn(IconData i, String t, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white12)),
    child: Row(children: [Icon(i), Expanded(child: Text(t, textAlign: TextAlign.center))]),
  );
}

// --- 2. التنقل الرئيسي (الرئيسية، بث مباشر، محفظة) ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;
  final List<Widget> _screens = [const TikTokFeed(), const Center(child: Text("اكتشف")), const LiveStreamScreen(), const Center(child: Text("الرسائل")), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "اكتشف"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv, color: Colors.red), label: "بث مباشر"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "صندوق الوارد"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "الملف"),
        ],
      ),
    );
  }
}

// --- 3. واجهة البث المباشر (LIVE) ---
class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.blueGrey[900]),
        const Positioned(top: 50, left: 20, child: Badge(label: Text("LIVE"), backgroundColor: Colors.red)),
        const Center(child: Icon(Icons.person, size: 100, color: Colors.white10)),
        Positioned(bottom: 20, left: 20, child: Row(children: [
          Container(width: 200, height: 40, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const TextField(decoration: InputDecoration(hintText: " أرسل تعليقاً...", border: InputBorder.none, contentPadding: EdgeInsets.only(left: 15)))),
          const SizedBox(width: 10),
          const Icon(Icons.card_giftcard, color: Colors.orange, size: 30),
        ])),
      ],
    );
  }
}

// --- 4. الملف الشخصي والمحفظة والإعدادات ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("الملف الشخصي"), actions: [
        IconButton(icon: const Icon(Icons.settings), onPressed: () => _showSettings(context)),
      ]),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 15),
          const Text("@Xontik_User", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_stat("1.2M", "متابع"), _stat("500", "أتابع")]),
          const SizedBox(height: 20),
          _walletCard(context),
          const Divider(),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: 9, itemBuilder: (c, i) => Container(margin: const EdgeInsets.all(1), color: Colors.white10, child: const Icon(Icons.play_arrow)))),
        ],
      ),
    );
  }

  Widget _stat(String v, String l) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.grey))]));

  Widget _walletCard(BuildContext context) => Container(
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.purple, Colors.blue]), borderRadius: BorderRadius.circular(15)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text("رصيد المحفظة"), Text("\$1,250.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]),
      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black), child: const Text("ربط المحفظة")),
    ]),
  );

  void _showSettings(BuildContext context) {
    showModalBottomSheet(context: context, builder: (c) => Container(
      color: Colors.grey[900],
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(leading: const Icon(Icons.lock), title: const Text("الخصوصية")),
        ListTile(leading: const Icon(Icons.wallet), title: const Text("إعدادات المحفظة والعملات")),
        ListTile(leading: const Icon(Icons.language), title: const Text("اللغة")),
        ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("تسجيل الخروج"), onTap: () => Navigator.popUntil(context, (route) => route.isFirst)),
      ]),
    ));
  }
}

// --- 5. محرك الفيديوهات (Feed) ---
class TikTokFeed extends StatelessWidget {
  const TikTokFeed({super.key});
  @override
  Widget build(BuildContext context) => PageView.builder(scrollDirection: Axis.vertical, itemBuilder: (c, i) => Container(
    color: Colors.black,
    child: Stack(children: [
      const Center(child: Icon(Icons.play_arrow, size: 100, color: Colors.white10)),
      Positioned(right: 15, bottom: 100, child: Column(children: const [Icon(Icons.favorite, size: 40), Text("2M"), SizedBox(height: 20), Icon(Icons.comment, size: 40), Text("10K")])),
    ]),
  ));
}

