import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final int index; 

  const ProductItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Producto ${index + 1}'),
      subtitle: Text('Cantidad: 100 | Precio: \$${(index + 1) * 10}.99'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          //TODO: Implementar edición de producto
        }
      ),
    );
  }
}