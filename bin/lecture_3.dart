import 'package:collection/collection.dart';

void main() {
  List<Map<String, dynamic>> products = [
    {
      'name': 'Laptop',
      'category': 'Electronics',
      'price': 1000,
      'quantity': 5,
    },
    {
      'name': 'Headphones',
      'category': 'Electronics',
      'price': 150,
      'quantity': 10
    },
    {
      'name': 'Shirt',
      'category': 'Clothing',
      'price': 50,
      'quantity': 20,
    },
    {
      'name': 'Shoes',
      'category': 'Clothing',
      'price': 120,
      'quantity': 15,
    },
    {
      'name': 'Book',
      'category': 'Stationery',
      'price': 20,
      'quantity': 50,
    },
  ];

  // Набір категорій товарів (уникальні категорії)
  Set<String> productCategories =
      products.map((product) => product['category'] as String).toSet();

  // Виведення всіх товарів
  print('Available Products:');
  for (final product in products) {
    print('${product['name']} (${product['category']}): '
        '\$${product['price']} (${product['quantity']} in stock)');
  }

  // Виведення унікальних категорій
  print('\nProduct Categories:');
  print(productCategories);

  // Кошик покупця (ключ — назва товару, значення — кількість у кошику)
  Map<String, int> cart = {};

  // Додаємо товари до кошику
  addToCart(products, cart, 'Laptop', 1);
  addToCart(products, cart, 'Shirt', 2);
  addToCart(products, cart, 'Book', 5);

  // Виведення кошика
  print('\nCart:');
  cart.forEach(
    (key, value) {
      print('$key: $value item(s)');
    },
  );

  // Фільтрація товарів за категорією
  String selectedCategory = 'Electronics';
  List<Map<String, dynamic>> filteredProducts =
      products.where((p) => p['category'] == selectedCategory).toList();

  // Виведення товарів з обраної категорії
  print('\nProducts in category "$selectedCategory":');
  for (final product in filteredProducts) {
    print('${product['name']}: \$${product['price']}');
  }

  // Оновлення інформації про товар (оновлення ціни)
  void updateProductPrice(String productName, double newPrice) {
    final product = products.firstWhereOrNull(
      (p) => p['name'] == productName,
    );

    if (product != null) {
      product['price'] = newPrice;
      print('Price of $productName updated to \$$newPrice');
    } else {
      print('Product not found!');
    }
  }

  // Оновлюємо ціну на ноутбук
  updateProductPrice('Laptop', 950);
  updateProductPrice('Headphones', 899);

  // Видаляємо товар з кошика
  void removeFromCart(String productName) {
    if (cart.containsKey(productName)) {
      var product = products.firstWhere((p) => p['name'] == productName);
      product['quantity'] += cart[productName]!;
      cart.remove(productName);
      print('Removed $productName from the cart.');
    } else {
      print('Product is not in the cart.');
    }
  }

  // Видаляємо "Shirt" з кошика
  removeFromCart('Shirt');

  // Виведення оновленого кошика
  print('\nUpdated Cart:');
  cart.forEach(
    (key, value) {
      print('$key: $value item(s)');
    },
  );
}

// Функція для додавання товару в кошик
void addToCart(
  List<Map<String, dynamic>> products,
  Map<String, int> cart,
  String productName,
  int quantity,
) {
  var product = products.firstWhereOrNull((p) => p['name'] == productName);

  if (product == null) {
    print('Product not found!');
    return;
  }

  if (product['quantity'] >= quantity) {
    cart.update(productName, (value) => value + quantity,
        ifAbsent: () => quantity);
    product['quantity'] -= quantity;
    print('Added $quantity $productName(s) to the cart.');
  } else {
    print('Not enough stock for $productName!');
  }
}
