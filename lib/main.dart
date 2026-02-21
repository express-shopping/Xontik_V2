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

// --- 2. الهيكل الرئيسي ---
class MainTikTokScaffold extends StatefulWidget {
  const MainTikTokScaffold({super.key});
  @override
  State<MainTikTokScaffold> createState() => _MainTikTokScaffoldState();
}

class _MainTikTokScaffoldState extends State<MainTikTokScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const TikTokFeedView(), const Center(child: Text("اكتشف")), const Center(child: Text("الكاميرا")), const Center(child: Text("الرسائل")), const ProfileScreen()];

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

// --- 3. الملف الشخصي مع قائمة الإعدادات المتكاملة ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () => _showSettingsMenu(context)),
          const SizedBox(width: 10),
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _actionBtn(context, "تعديل الملف", () => Navigator.push(context, MaterialPageRoute(builder: (c) => const EditProfileScreen()))),
            const SizedBox(width: 5),
            _actionBtn(context, "مشاركة الملف", () {}),
          ]),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1), itemCount: 12, itemBuilder: (c, i) => Container(color: Colors.white10, child: const Icon(Icons.play_arrow, color: Colors.white24)))),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) => ListView(
          controller: controller,
          children: [
            const Padding(padding: EdgeInsets.all(15), child: Center(child: Text("الإعدادات والخصوصية", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
            _menuItem(Icons.live_tv, "البث المباشر (LIVE)", Colors.redAccent, () {}),
            _menuItem(Icons.account_balance_wallet, "المحفظة (الأرباح)", Colors.amber, () => _showWallet(context)),
            _menuItem(Icons.person_outline, "إدارة الحساب", Colors.white, () {}),
            _menuItem(Icons.lock_outline, "الخصوصية", Colors.white, () {}),
            _menuItem(Icons.language, "اللغة", Colors.white, () {}),
            _menuItem(Icons.report_problem_outlined, "الإبلاغ عن مشكلة", Colors.white, () {}),
            _menuItem(Icons.help_outline, "مركز المساعدة", Colors.white, () {}),
            _menuItem(Icons.security, "مركز الأمان", Colors.white, () {}),
            const Divider(),
            _menuItem(Icons.logout, "تسجيل الخروج", Colors.red, () {}),
          ],
        ),
      ),
    );
  }

  void _showWallet(BuildContext context) {
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text("ربط وسائل الدفع"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        _paymentOption(Icons.paypal, "PayPal", Colors.blue),
        _paymentOption(Icons.account_balance, "حساب بنكي", Colors.green),
        _paymentOption(Icons.currency_bitcoin, "محفظة رقمية", Colors.orange),
      ]),
    ));
  }

  Widget _paymentOption(IconData i, String t, Color c) => ListTile(leading: Icon(i, color: c), title: Text(t), onTap: () {});
  Widget _menuItem(IconData i, String t, Color c, VoidCallback o) => ListTile(leading: Icon(i, color: c), title: Text(t), onTap: o);
  Widget _stat(String v, String l) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.grey, fontSize: 13))]));
  Widget _actionBtn(BuildContext context, String t, VoidCallback o) => GestureDetector(onTap: o, child: Container(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))));
}

// --- 4. واجهة تعديل الملف الشخصي (التي طلبتها بدقة) ---
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _bioController = TextEditingController(text: "مبدع في XONTIK");
  final TextEditingController _nameController = TextEditingController(text: "Xontik_Official");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("تعديل الملف الشخصي")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.camera_alt, size: 30)),
            const SizedBox(height: 10),
            const Text("تغيير الصورة", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 30),
            _editField("الاسم", _nameController, "يمكنك تغيير اسمك مرة واحدة كل 30 يوم."),
            const SizedBox(height: 20),
            _editField("السيرة الذاتية", _bioController, "أخبر العالم عنك (حد أقصى 80 حرفاً)", maxLength: 80),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFeb3349), minimumSize: const Size(double.infinity, 50)),
              child: const Text("حفظ التغييرات"),
            )
          ],
        ),
      ),
    );
  }

  Widget _editField(String label, TextEditingController ctrl, String hint, {int? maxLength}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey)),
      TextField(
        controller: ctrl,
        maxLength: maxLength,
        decoration: InputDecoration(helperText: hint, helperMaxLines: 2, enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white12))),
      ),
    ],
  );
}

// --- محرك الفيديوهات (Feed) ---
class TikTokFeedView extends StatelessWidget {
  const TikTokFeedView({super.key});
  @override
  Widget build(BuildContext context) => PageView.builder(scrollDirection: Axis.vertical, itemBuilder: (context, index) => Stack(fit: StackFit.expand, children: [
    Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blueGrey[900]!, Colors.black], begin: Alignment.topCenter))),
    Positioned(left: 10, bottom: 100, child: Column(children: const [Icon(Icons.favorite, size: 40), Text("2M"), SizedBox(height: 20), Icon(Icons.chat_bubble, size: 40), Text("15K")])),
    Positioned(right: 15, bottom: 25, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text("@Xontik_Creator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text("تم تحديث كافة أنظمة الخصوصية والمحفظة! 🔥")])),
  ]));
}

