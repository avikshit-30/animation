class Item {
  final int id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});
}

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});
}
