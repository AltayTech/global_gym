import 'package:flutter/foundation.dart';



class MealCart with ChangeNotifier {
  final int id;
  final String title;
  final String price;
  final String featured_media_url;
  int productCount;

  MealCart(
      {this.id,
      this.title,
      this.price,
      this.featured_media_url,
      this.productCount,
      });

  factory MealCart.fromJson(Map<String, dynamic> parsedJson) {
    return MealCart(
      id: parsedJson['id'],
      title: parsedJson['title'],
      price: parsedJson['price'],
      featured_media_url: parsedJson['featured_media_url'],
      productCount: parsedJson['how_many'],
    );
  }
}
