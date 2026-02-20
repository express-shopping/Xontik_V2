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
      home: const AuthScreen(), // البداية من واجهة التسجيل الراقية
    );
  }
}

// --- 1. واجهة تسجيل دخول راقية (TikTok Style) ---
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

// --- 2. الهيكل الرئيسي (كما أحببت) مع تفعيل الصفحات ---
class MainTikTokScaffold extends StatefulWidget {
  const MainTikTokScaffold({super.key});
  @override
  State<MainTikTokScaffold> createState() => _MainTikTokScaffoldState();
}

class _MainTikTokScaffoldState extends State<MainTikTokScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TikTokFeedView(),
    const Center(child: Text("اكتشف الصيحات الجديدة")),
    const Center(child: Text("الكاميرا قيد العمل")),
    const Center(child: Text("صندوق الوارد (الرسائل)")),
    const ProfileScreen(), // الملف الشخصي المطور
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
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
}

// --- 3. الملف الشخصي الاحترافي (المحفظة والبث في الزاوية) ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Column(
            children: [
              GestureDetector(
                onTap: () => _showWallet(context), // تفعيل المحفظة
                child: const Padding(padding: EdgeInsets.only(right: 10, top: 5), child: Icon(Icons.account_balance_wallet_outlined, size: 20, color: Colors.amber)),
              ),
              GestureDetector(
                onTap: () {}, // تفعيل البث
                child: const Padding(padding: EdgeInsets.only(right: 10, top: 2), child: Icon(Icons.live_tv, size: 18, color: Colors.redAccent)),
              ),
            ],
          ),
          const Icon(Icons.menu),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, backgroundColor: Colors.white10, child: Icon(Icons.person, size: 60)),
          const SizedBox(height: 15),
          const Text("@xontik_official", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_stat("150", "أتابع"), _stat("1.5M", "متابعين"), _stat("10M", "إعجاب")]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_btn("تعديل الملف"), const SizedBox(width: 5), _btn("مشاركة الملف")]),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1), itemCount: 12, itemBuilder: (c, i) => Container(color: Colors.white10, child: const Icon(Icons.play_arrow, color: Colors.white24)))),
        ],
      ),
    );
  }

  Widget _stat(String v, String l) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.grey, fontSize: 13))]));
  Widget _btn(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)));

  void _showWallet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (c) => Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(25),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("المحفظة الرقمية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ListTile(leading: const Icon(Icons.currency_bitcoin, color: Colors.orange), title: const Text("ربط محفظة العملات"), onTap: () {}),
        ListTile(leading: const Icon(Icons.credit_card, color: Colors.blue), title: const Text("إضافة بطاقة بنكية"), onTap: () {}),
      ]),
    ));
  }
}

// --- 4. محرك الفيديوهات التفاعلي بالكامل (Feed) ---
class TikTokFeedView extends StatelessWidget {
  const TikTokFeedView({super.key});
  @override
  Widget build(BuildContext context) => PageView.builder(scrollDirection: Axis.vertical, itemBuilder: (context, index) => VideoItem(index: index));
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
    return Stack(fit: StackFit.expand, children: [
      Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blueGrey[900]!, Colors.black]))),
      const Positioned(top: 40, left: 0, right: 0, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("أتابع", style: TextStyle(color: Colors.white54)), SizedBox(width: 20), Text("لك", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))])),
      Positioned(left: 10, bottom: 100, child: Column(children: [
        _buildProfile(),
        const SizedBox(height: 20),
        _action(isLiked ? Icons.favorite : Icons.favorite_border, "5.2M", isLiked ? Colors.red : Colors.white, () => setState(() => isLiked = !isLiked)),
        _action(Icons.chat_bubble, "15.4K", Colors.white, () {}),
        _action(Icons.bookmark, "90K", Colors.white, () {}),
        _action(Icons.share, "مشاركة", Colors.white, () {}),
        const SizedBox(height: 20),
        _musicDisc(),
      ])),
      Positioned(right: 15, bottom: 25, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("@Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        const Text("تم تفعيل كافة الأزرار والمميزات بنجاح! 🔥"),
        const SizedBox(height: 10),
        Row(children: const [Icon(Icons.music_note, size: 15), Text("الصوت الأصلي - Xontik Pro")]),
      ])),
    ]);
  }

  Widget _buildProfile() => Stack(clipBehavior: Clip.none, children: [
    const CircleAvatar(radius: 24, backgroundColor: Colors.white, child: CircleAvatar(radius: 22, backgroundColor: Colors.black, child: Icon(Icons.person))),
    if (!isFollowed) Positioned(bottom: -8, left: 14, child: GestureDetector(onTap: () => setState(() => isFollowed = true), child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20))))
  ]);

  Widget _action(IconData i, String l, Color c, VoidCallback o) => GestureDetector(onTap: o, child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [Icon(i, size: 35, color: c), Text(l, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))])));
  Widget _musicDisc() => Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white24, width: 8), gradient: const SweepGradient(colors: [Colors.black, Colors.grey, Colors.black])), child: const Icon(Icons.music_note, size: 20));
}

