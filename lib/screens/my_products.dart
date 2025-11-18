import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  Future<List<dynamic>> fetchMyProducts(CookieRequest request) async {
    final response = await request.get("http://localhost:8000/my-products/");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text("You have no products yet"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: p['thumbnail'] != ""
                      ? Image.network(p['thumbnail'], width: 60, height: 60)
                      : const Icon(Icons.image_not_supported),
                  title: Text(p['name']),
                  subtitle: Text("Rp ${p['price']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}