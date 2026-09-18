import 'dart:io';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  const ItemCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)), 
      curve: Curves.easeOutCubic,//ذا المنحنى يجعل الحركة تبدأ (بسرعة قوية) ثم تتباطأ (بنعومة شديدة) قبل أن تتوقف في مكانها
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), 
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: item.imagePath.isNotEmpty
                      ? Image.file(
                          File(item.imagePath),
                          width: 95,
                          height: 95,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name, 
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B0000).withOpacity(0.1), 
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${item.price} ريال', 
                        style: const TextStyle(fontSize: 15, color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [                 
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
                      onPressed: onEdit,
                      tooltip: 'تعديل',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete_rounded, color: Colors.red, size: 20),
                      onPressed: onDelete,
                      tooltip: 'حذف',
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPlaceholder() {
    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xFF8B0000).withOpacity(0.05), 
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(Icons.fastfood_rounded, color: Color(0xFF8B0000), size: 40),
    );
  }
}