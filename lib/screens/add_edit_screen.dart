import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/item_model.dart';
import '../providers/item_provider.dart';

class AddEditScreen extends StatefulWidget {
  final String category;
  final ItemModel? item;

  const AddEditScreen({super.key, required this.category, this.item});
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  String _imagePath = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _priceController = TextEditingController(text: widget.item != null ? widget.item!.price.toString() : '');
    _imagePath = widget.item?.imagePath ?? '';
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _saveForm(ItemProvider provider) {
    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(
        id: widget.item?.id,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        category: widget.category,
        imagePath: _imagePath,
      );

      if (widget.item == null) {
        provider.addItem(newItem);
      } else {
        provider.updateItem(newItem);
      }
      
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.item != null;
    ItemProvider provider = context.watch<ItemProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0EC), 
      appBar: AppBar(
        title: Text(isEdit ? 'تعديل الصنف' : 'إضافة صنف جديد', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF8B0000).withOpacity(0.4), width: 2), 
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)) 
                      ],
                    ),
                    child: _imagePath.isEmpty
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_rounded, size: 55, color: Color(0xFF8B0000)),
                              SizedBox(height: 12),
                              Text('اضغط لاختيار صورة رائعة للصنف', style: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.file(File(_imagePath), fit: BoxFit.cover),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'اسم الصنف',
                    labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.fastfood, color: Color(0xFF8B0000)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF8B0000), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'الرجاء إدخال اسم الصنف' : null,
                ),
                
                const SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'السعر (ريال)',
                    labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.attach_money, color: Color(0xFF8B0000)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF8B0000), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'الرجاء إدخال السعر';
                    if (double.tryParse(value) == null) return 'أدخل رقماً صحيحاً';
                    return null;
                  },
                ),
                
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 60, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000), 
                      elevation: 8,
                      shadowColor: const Color(0xFF8B0000).withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),            
                    onPressed: () => _saveForm(provider),
                    child: const Text(
                      'حفظ البيانات', 
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}