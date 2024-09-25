import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paty_cosmeticos/features/inventory/presentation/providers/inventory_providers.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/products/product_item.dart';

class ProductsTab extends ConsumerStatefulWidget {
  const ProductsTab({super.key});

  @override
  ConsumerState<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends ConsumerState<ProductsTab> {
  String _searchQuery = '';
  String _selectedCategory = 'Todas';

  @override
  Widget build(BuildContext context) {
    //Se usa el provider de productos
    final productsAsync = ref.watch(productsProvider);
    //Se usa el provider de categorías
    final categoriesAsync = ref.watch(categoriesProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar producto...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        // Dropdown de categorías
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: categoriesAsync.when(
            data: (categories) {
              final allCategories = ['Todas', ...categories];

              return DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedCategory,
                items: allCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error al cargar las categorías: $error'),
          ),
        ),
        // Lista de productos
        Expanded(
          child: productsAsync.when(
            data: (products) {
              //Filtrar productos por categoría y búsqueda
              final filteredProducts = products.where((product) {
                final matchesSearchQuery = _searchQuery.isEmpty || 
                    product.name.toLowerCase().contains(_searchQuery.toLowerCase());
                final matchesCategory = _selectedCategory == 'Todas' ||
                    product.category == _selectedCategory;

                return matchesSearchQuery && matchesCategory;
              }).toList();

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: Text('No se encontraron productos'),
                );
              }

              return ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductItem(product: product);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}