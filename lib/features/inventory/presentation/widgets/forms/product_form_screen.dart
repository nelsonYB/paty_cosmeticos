import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/providers/inventory_providers.dart';


class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double purchasePrice = 0;
  double sellingPrice = 0;
  int stock = 0;
  String _selectedCategory = '';
  TextEditingController newCategoryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

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
              // Dropdown de categorías dinámicas
              categoriesAsync.when(
                data: (categories) {
                  final allCategories = categories;

                  return DropdownButtonFormField<String>(
                    value: _selectedCategory.isEmpty ? null : _selectedCategory,
                    hint: const Text('Seleccionar una Categoría'),
                    items: allCategories.map((category) {
                      return DropdownMenuItem<String>(
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
                      // Validar que se haya seleccionado una categoría existente o ingresado una nueva
                      if ((value == null || value.isEmpty) && newCategoryController.text.isEmpty) {
                        return 'Por favor, seleccione una categoría o ingrese una nueva';
                      }
                      return null;
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error al cargar categorías: $error'),
              ),
              
              // Campo para agregar una nueva categoría
              TextField(
                controller: newCategoryController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción para el botón de cancelar
                      context.pop();
                    }, 
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveProduct,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green.shade200),
                    ),
                    child: const Text('Guardar Producto'),
                  ),
                ],
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
      final category = newCategoryController.text.isNotEmpty
         ? newCategoryController.text //Si se ingresó una nueva categoría
         : _selectedCategory; //Si se seleccionó una categoría existente

      final user = ref.read(supabaseClientProvider).auth.currentUser;

      if (user == null) {
        context.go('/login');
        return;
      }

      //Crear una instancia del producto
      final product = Product(
        name: name,
        description: description,
        purchasePrice: purchasePrice,
        sellingPrice: sellingPrice,
        stock: stock,
        category: category,
        userId: user.id,
      );
      
      try {
        //Uso del provider para crear un nuevo producto
        await ref.read(inventoryRepositoryProvider).createProduct(product);

        //Refrescar la lista de productos
        ref.invalidate(productsProvider);

        //Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        //Navegar a la pantalla de inventario
        context.pop();
      } catch (e) {
        //Mostrar mensaje de error
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
