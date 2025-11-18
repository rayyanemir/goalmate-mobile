// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    int stock;
    String category;
    String brand;
    double rating;
    String thumbnail;
    String description;
    bool isFeatured;
    int? userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.stock,
        required this.category,
        required this.brand,
        required this.rating,
        required this.thumbnail,
        required this.description,
        required this.isFeatured,
        required this.userId,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        brand: json["brand"],
        rating: json["rating"]?.toDouble(),
        thumbnail: json["thumbnail"]??"",
        description: json["description"],
        isFeatured: json["is_featured"]??false,
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "brand": brand,
        "rating": rating,
        "thumbnail": thumbnail,
        "description": description,
        "is_featured": isFeatured,
        "user_id": userId,
    };
}
