// ignore_for_file: prefer_final_fields, avoid_print

import 'package:hive/hive.dart';

import 'package:flutter/cupertino.dart';
part 'whishlist_provider.g.dart';

@HiveType(typeId: 1)
class Whishlist extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List image;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final int price;

  // final Color color;
  Whishlist({
    // required this.productId,
    required this.image,
    required this.title,
    required this.price,
    required this.id,
  });

  Whishlist copyWith({
    String? id,
    List? image,
    String? title,
    int? price,
  }) {
    return Whishlist(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }
}

class WhishlistProvider with ChangeNotifier {
  Map<String, Whishlist> _whishlist = {};
  Map<String, Whishlist> get whishlist => _whishlist;
  var box = Hive.box<Whishlist>("wishlist_houses");

  void addOrRemoveWish(String title, String id, List image, int price) {
    if (_whishlist.containsKey(id)) {
      removeItem(id);
      box.delete(title);
    } else {
      _whishlist.putIfAbsent(
        id,
        () => Whishlist(
          id: id,
          image: image,
          title: title,
          price: price,
        ),

       
      );
      box.put(
          title, Whishlist(image: image, title: title, price: price, id: id));
      print(title);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _whishlist.remove(id);
    box.delete(id);
    print(box.get(id));
    notifyListeners();
  }

  void clearWish() {
    _whishlist.clear();
    box.deleteAll(box.keys);
    notifyListeners();
  }
}