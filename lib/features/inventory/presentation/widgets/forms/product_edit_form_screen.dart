import 'package:flutter/material.dart';

class ProductEditFormScreen extends StatelessWidget {
  final int productId;

  const ProductEditFormScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // Implementa la lógica de edición del producto aquí
    return Scaffold(
      appBar: AppBar(title: Text('Editar Producto')),
      body: Center(
        child: Text('Formulario de edición para el producto con ID: $productId'),
      ),
    );
  }
}