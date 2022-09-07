class Money {
  Money({
    required this.money
  });
  
  double money;

}

List<Money> acceptableMoney = [
  Money(money: 2000),
  Money(money: 5000),
  Money(money: 10000),
  Money(money: 20000),
  Money(money: 50000),
];

class Menu {

  Menu({
    required this.mark,
    required this.name,
    required this.price,
    required this.stock,
  });

  final String mark;
  final String name;
  final double price;
  int stock;
}

List<Menu> menu = [
  Menu(mark: 'a', name: 'Biskuit', price: 6000, stock: 1),
  Menu(mark: 'b', name: 'Chips', price: 8000, stock: 5),
  Menu(mark: 'c', name: 'Oreo', price: 10000, stock: 3),
  Menu(mark: 'd', name: 'Tango', price: 12000, stock: 4),
  Menu(mark: 'e', name: 'Cokelat', price: 15000, stock: 10),
];

List<Menu> itemPurchased = [];