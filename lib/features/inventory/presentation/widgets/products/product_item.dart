import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product; 

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Stock: ${product.stock} | Precio Venta: \$${product.sellingPrice}'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          if (product.id != null) {
            final url = '/inventory/edit-product/${product.id}';
            GoRouter.of(context).go(url);
          } else {
            // Manejar el caso donde el id es null, por ejemplo, mostrar un mensaje de error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('El ID del producto no es válido'))
            );
          }
        }
      ),
    );
  }
}