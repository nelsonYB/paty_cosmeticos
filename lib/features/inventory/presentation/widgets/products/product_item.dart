import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product; 

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Stock: ${product.stock} | Precio: \$${product.sellingPrice}'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          //TODO: Implementar edición de producto
        }
      ),
    );
  }
}