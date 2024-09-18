class Product {
  final String name;
  final String description;
  final double purchasePrice;
  final double sellingPrice;
  final int stock;

  Product({ 
    required this.name, 
    required this.description, 
    required this.purchasePrice, 
    required this.sellingPrice, 
    required this.stock
  });
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'purchase_price': purchasePrice,
    'sale_price': sellingPrice,
    'stock_quantity': stock
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      purchasePrice: json['purchase_price'],
      sellingPrice: json['sale_price'],
      stock: json['stock_quantity']
    );
  }
}