import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paty_cosmeticos/features/inventory/data/repositories/supabase_inventory_repository_impl.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';
import 'package:paty_cosmeticos/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Proveeedor del cliente de Supabase
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Proveedor del repositorio de inventario
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return SupabaseInventoryRepositoryImpl(ref.read(supabaseClientProvider));
});

// Proveedor de productos
final productsProvider = FutureProvider<List<Product>>((ref) async{
  final repository = ref.read(inventoryRepositoryProvider);
  return repository.getProducts();
});

// Proveedor de categorías
final categoriesProvider = FutureProvider<List<String>>((ref) async{
  final repository = ref.read(inventoryRepositoryProvider);
  return repository.getCategories();
});