class Product {
  final int? id; // El id es opcional
  final String name;
  final String description;
  final double purchasePrice;
  final double sellingPrice;
  final int stock;
  final String category;
  final String userId;

  Product({ 
    this.id,
    required this.name, 
    required this.description, 
    required this.purchasePrice, 
    required this.sellingPrice, 
    required this.stock,
    required this.category,
    required this.userId
  });
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'purchase_price': purchasePrice,
    'sale_price': sellingPrice,
    'stock_quantity': stock,
    'category': category,
    'user_id': userId
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product( 
      //Se asgina el id si está disponible
      id: json['id'],
      name: json['name'],
      description: json['description'],
      purchasePrice: json['purchase_price'],
      sellingPrice: json['sale_price'],
      stock: json['stock_quantity'],
      category: json['category'],
      userId: json['user_id'] ?? 'ID de usuario no disponible'
    );
  }

}