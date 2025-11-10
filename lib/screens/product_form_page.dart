import 'package:flutter/material.dart';
import 'package:goalmate_mobile/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "others";
  bool _isFeatured = false;
  int _stock = 0;
  String _brand = "";
  double _rating = 0.0;

  final List<String> _categories = [
    'jersey',
    'shoes',
    'ball',
    'accessories',
    'others',
  ];

  bool _isValidUrl(String url) {
    if (url.isEmpty) return false;
    final uri = Uri.tryParse(url);
    return uri != null && (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _name = "";
      _price = 0;
      _description = "";
      _thumbnail = "";
      _category = "others";
      _isFeatured = false;
      _stock = 0;
      _brand = "";
      _rating = 0.0;
    });
  }

  String _displayCategory(String c) {
    if (c.isEmpty) return c;
    return c[0].toUpperCase() + c.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Product name',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 255,
                  onChanged: (v) => _name = v.trim(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Name cannot be empty';
                    if (v.trim().length > 255) return 'Name must be at most 255 characters';
                    return null;
                  },
                ),
              ),

              // Price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Integer, non-negative',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _price = int.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Price cannot be empty';
                    final n = int.tryParse(v.trim());
                    if (n == null) return 'Price must be an integer';
                    if (n < 0) return 'Price cannot be negative';
                    return null;
                  },
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Product description (min 10 chars)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  onChanged: (v) => _description = v.trim(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Description cannot be empty';
                    if (v.trim().length < 10) return 'Description must be at least 10 characters';
                    return null;
                  },
                ),
              ),

              // Thumbnail (optional)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Thumbnail URL (optional)',
                    hintText: 'https://example.com/image.jpg',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (v) => _thumbnail = v.trim(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    if (!_isValidUrl(v.trim())) return 'Invalid URL format';
                    return null;
                  },
                ),
              ),

              // Category
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(_displayCategory(c))))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v ?? 'others'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Category must be selected';
                    return null;
                  },
                ),
              ),

              // Featured
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: SwitchListTile(
                  title: const Text('Featured'),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
              ),

              // Stock
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Integer, non-negative',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _stock = int.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Stock cannot be empty';
                    final n = int.tryParse(v.trim());
                    if (n == null) return 'Stock must be an integer';
                    if (n < 0) return 'Stock cannot be negative';
                    return null;
                  },
                ),
              ),

              // Brand (optional)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Brand (optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 100,
                  onChanged: (v) => _brand = v.trim(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    if (v.length > 100) return 'Brand must be at most 100 characters';
                    return null;
                  },
                ),
              ),

              // Rating
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Rating',
                    hintText: 'Float, between 0.0 and 5.0',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) => _rating = double.tryParse(v) ?? 0.0,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Rating cannot be empty';
                    final n = double.tryParse(v.trim());
                    if (n == null) return 'Rating must be a valid number';
                    if (n < 0.0 || n > 5.0) return 'Rating must be between 0.0 and 5.0';
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Save button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Product saved'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: $_name'),
                                  Text('Price: $_price'),
                                  Text('Description: $_description'),
                                  Text('Category: ${_displayCategory(_category)}'),
                                  Text('Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
                                  Text('Featured: ${_isFeatured ? "Yes" : "No"}'),
                                  Text('Stock: $_stock'),
                                  Text('Brand: ${_brand.isEmpty ? "-" : _brand}'),
                                  Text('Rating: ${_rating.toStringAsFixed(1)}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _resetForm();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}