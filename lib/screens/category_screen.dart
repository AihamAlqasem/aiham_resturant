import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../widgets/item_card.dart';
import 'add_edit_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  const CategoryScreen({super.key, required this.categoryName, required this.categoryId});
  @override
  Widget build(BuildContext context) {
    
    ItemProvider provider = context.watch<ItemProvider>();

    final categoryItems = provider.items().where((item) => item.category == categoryId).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0EC), 
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 1.2)),
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
        child: categoryItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    const Text(
                      'لا يوجد أصناف حالياً.\nأضف صنفاً جديداً!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 80), 
                itemCount: categoryItems.length,
                itemBuilder: (context, index) {
                  final item = categoryItems[index];
                  return ItemCard(
                    item: item,
                    index: index,
                    onEdit: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddEditScreen(category: categoryId, item: item),
                      ));
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.red),
                              SizedBox(width: 10),
                              Text('تأكيد الحذف'),
                            ],
                          ),
                          content: const Text('هل أنت متأكد أنك تريد حذف هذا الصنف نهائياً؟', style: TextStyle(fontSize: 16)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('إلغاء', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B0000), // مطابق للثيم
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                              ),
                              onPressed: () {      
                                provider.deleteItem(item.id!);
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('حذف', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.add, size: 24),
        label: const Text('إضافة صنف', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddEditScreen(category: categoryId),
          ));
        },
      ),
    );
  }
}