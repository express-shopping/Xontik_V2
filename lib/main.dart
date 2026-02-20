import 'package:flutter/material.dart';

void main() => runApp(const XontikProApp());

class XontikProApp extends StatelessWidget {
  const XontikProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XONTIK PRO',
      locale: const Locale('ar', 'AE'), // دعم العربية
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.redAccent,
      ),
      home: const AuthScreen(), // البداية بصفحة تسجيل الدخول
    );
  }
}

// --- صفحة تسجيل الدخول الراقية ---
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.red.withOpacity(0.3), Colors.black],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("XONTIK", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, letterSpacing: 5)),
            const SizedBox(height: 10),
            const Text("أنشئ حسابك وابدأ الإبداع", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 50),
            _buildInput("البريد الإلكتروني", Icons.email),
            const SizedBox(height: 20),
            _buildInput("كلمة المرور", Icons.lock, isPass: true),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainVideoScreen())),
              child: const Text("تسجيل الدخول", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon, {bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.redAccent),
        hintText: hint,
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }
}

// --- واجهة الفيديوهات الرئيسية (مثل تيك توك) ---
class MainVideoScreen extends StatefulWidget {
  const MainVideoScreen({super.key});

  @override
  State<MainVideoScreen> createState() => _MainVideoScreenState();
}

class _MainVideoScreenState extends State<MainVideoScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // محاكي الفيديو (خلفية سوداء)
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) => Container(color: Colors.black, child: const Center(child: Icon(Icons.play_circle_outline, size: 100, color: Colors.white10))),
          ),
          
          // الأزرار بجهة اليسار (ثابتة وراقية)
          Positioned(
            left: 20, // جهة اليسار كما طلبت
            bottom: 120,
            child: Column(
              children: [
                _buildUserAvatar(),
                const SizedBox(height: 25),
                _buildSideButton(isLiked ? Icons.favorite : Icons.favorite_border, "2.5K", isLiked ? Colors.red : Colors.white, () => setState(() => isLiked = !isLiked)),
                _buildSideButton(Icons.comment, "400", Colors.white, () {}),
                _buildSideButton(Icons.share, "مشاركة", Colors.white, () {}),
              ],
            ),
          ),

          // وصف الفيديو أسفل اليمين
          Positioned(
            right: 20,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("@XONTIK_PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 10),
                Text("هذا هو التصميم النهائي الذي حلمت به 🚀", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildUserAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const CircleAvatar(radius: 25, backgroundColor: Colors.black, child: Icon(Icons.person, color: Colors.white)),
        ),
        Positioned(bottom: -10, left: 18, child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20, color: Colors.white))),
      ],
    );
  }

  Widget _buildSideButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'اكتشف'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'الرسائل'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
      ],
    );
  }
}

