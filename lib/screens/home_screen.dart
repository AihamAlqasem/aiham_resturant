import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToCategory(BuildContext context,String categoryName,String categoryId,) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: categoryName,
          categoryId: categoryId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0EC), 
      appBar: AppBar(
        title: const Text('مطعم الأيهم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 1.2)),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black45,
        backgroundColor: const Color(0xFF8B0000), 
        foregroundColor: Colors.white,
        toolbarHeight: 80, 
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), 
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 28),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
          const SizedBox(width: 10), 
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFF3F0EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أهلاً بك يا غالي! ',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF8B0000)), 
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFFDD2476).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('عرض اليوم! 🔥', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('خصم 20% على جميع الوجبات لفترة محدودة', style: TextStyle(color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                      ),
                      const Icon(Icons.local_offer, color: Colors.white, size: 50),
                    ],
                  ),
                ),
                
                const SizedBox(height: 60), 
                
                const Text(
                  'ماذا تشتهي اليوم؟', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)
                ),
                
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                        context, 
                        'وجبات', 
                        'meals', 
                        Icons.lunch_dining, 
                        [const Color(0xFFFF9933), const Color(0xFFE65C00)], 
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildCategoryCard(
                        context, 
                        'عصائر', 
                        'juices', 
                        Icons.local_drink, 
                        [const Color(0xFF00B4DB), const Color(0xFF0083B0)], 
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40), 
            Row(
              children: [              
                Expanded(
                  child: _buildCategoryCard(
                    context, 
                    'حلويات', 
                    'desserts', 
                    Icons.cake, 
                    [const Color(0xFF9D50BB), const Color(0xFF6E48AA)], 
                  ),
                ),
                const SizedBox(width: 20),  
                Expanded(
                  child: _buildCategoryCard(
                    context, 
                    'شعبيات', 
                    'traditional',
                    Icons.soup_kitchen, 
                    [const Color(0xFFC67700), const Color(0xFF8B4513)], 
                  ),
                ),
              ],
            ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String categoryId, IconData icon, List<Color> gradientColors) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, title, categoryId),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: gradientColors[1].withOpacity(0.5), blurRadius: 12, offset: const Offset(0, 6))
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(icon, size: 110, color: Colors.white.withOpacity(0.2)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}