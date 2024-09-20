import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/features/inventory/data/inventory_repository_impl.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/product_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  String _searchQuery = '';
  String _selectedCategory = 'Todas';
  List<String> _categories = ['Todas', 'Shampoo', 'Acondicionador', 'Mascarilla', 'Tinte', 'Otros'];

  late Future<List<Product>> _productsFuture;

  @override
  void initState(){
    super.initState();
    _productsFuture = InventoryRepositoryImpl(Supabase.instance.client).getProducts();
  }

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedCategory,
            items: _categories.map((String category) {
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
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _productsFuture, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay productos disponibles'));
              }
              //Productos obtenidos de Supabase
              final products = snapshot.data!;

              //Filtrar productos por categoría
              final filteredProducts = products.where((product) {
                final matchesSearchQuery = _searchQuery.isEmpty ||
                  product.name.toLowerCase().contains(_searchQuery.toLowerCase());
                final matchesCategory = _selectedCategory == 'Todas' || 
                  product.category == _selectedCategory;

                return matchesSearchQuery && matchesCategory;
              }).toList();

              return ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductItem(product: product);
                },
              );

            }
          ),
        ),
      ],
    );
  }
}