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
  String _selectedCategory = '';
  TextEditingController _newCategoryController = TextEditingController();

  final List<String> _categories = ['Shampoo', 'Acondicionador', 'Mascarilla', 'Tinte', 'Otros'];

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
              // DropdownButtonFormField para seleccionar una categoría
              DropdownButtonFormField<String>(
                value: _selectedCategory.isEmpty ? null : _selectedCategory,
                hint: const Text('Selecciona una Categoría'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty && _newCategoryController.text.isEmpty) {
                    return 'Por favor, selecciona o ingresa una categoría';
                  }
                  return null;
                },
              ),
              // TextFormField para agregar una nueva categoría
              TextField(
                controller: _newCategoryController,
                decoration: const InputDecoration(labelText: 'Agregar nueva categoría (opcional)'),
              ),
              //Formulario para agregar un nuevo producto
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
      //Verificar si se ingresó una nueva categoría o se seleccionó una existente
      final category = _newCategoryController.text.isNotEmpty
         ? _newCategoryController.text 
         : _selectedCategory;


      final product = Product(
        name: name,
        description: description,
        purchasePrice: purchasePrice,
        sellingPrice: sellingPrice,
        stock: stock,
        category: category,
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
