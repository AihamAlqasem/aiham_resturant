import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0EC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF8B0000), 
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: Colors.black45,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'عن التطبيق والمطور',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, shadows: [Shadow(color: Colors.black87, blurRadius: 5)]),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B0000), Color(0xFF5A0000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                  ),
                  const Center(
                    child: Icon(Icons.restaurant, size: 100, color: Colors.white12),
                  ),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFF3F0EC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoCard(
                    icon: Icons.info_outline,
                    title: 'تطبيق مطعم الأيهم',
                    subtitle: 'نسخة تعليمية 1.0.0\nمشروع متكامل يطبق مفاهيم إدارة الحالة وقواعد البيانات المحلية.',
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Icon(Icons.developer_mode, color: Color(0xFF8B0000)),
                      SizedBox(width: 10),
                      Text(
                        'المطور',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),                
                  _buildDeveloperCard(),                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
        ],
        border: Border.all(color: const Color(0xFF8B0000).withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, size: 45, color: const Color(0xFF8B0000)),
          const SizedBox(height: 15),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.5)),
        ],
      ),
    );
  }
  Widget _buildDeveloperCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B0000), Color(0xFFDD2476)], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: const Color(0xFF8B0000).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 55, color: Colors.white), 
          ),
          SizedBox(height: 20),
          Text(
            'أيهم صادق عبدالواحد ال قاسم',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'مهندس ذكاء اصطناعي وبيانات ضخمة',
            style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          Divider(color: Colors.white24, thickness: 1.5),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.code, color: Colors.white),
              SizedBox(width: 10),
              Text('تم التطوير باستخدام فلاتر', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}