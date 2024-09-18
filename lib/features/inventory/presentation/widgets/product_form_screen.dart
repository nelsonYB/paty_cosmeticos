import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/inventory_repository_impl.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double purchasePrice = 0;
  double sellingPrice = 0;
  int stock = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Precio de Compra'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  purchasePrice = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Precio de Venta'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  sellingPrice = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cantidad en Stock'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  stock = int.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Guardar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProduct() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      final product = Product(
        name: name,
        description: description,
        purchasePrice: purchasePrice,
        sellingPrice: sellingPrice,
        stock: stock,
      );
      
      try {
        await InventoryRepositoryImpl(Supabase.instance.client).createProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear producto: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
