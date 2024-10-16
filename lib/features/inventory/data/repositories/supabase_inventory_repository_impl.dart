import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/inventory_repository.dart';
import '../../domain/entities/product.dart';


class SupabaseInventoryRepositoryImpl implements InventoryRepository {
  final SupabaseClient _supabaseClient;

  SupabaseInventoryRepositoryImpl(this._supabaseClient);

  @override
  Future<List<Product>> getProducts(String userId) async {
    try {
      final data = await _supabaseClient
          .from('products')
          .select()
          .eq('user_id', userId);
          
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  @override
  Future<void> createProduct(Product product) async {

    try {
      await _supabaseClient.from('products').insert(product.toJson());
    } catch (e) {
      throw Exception('Error creating product: $e');
    }

  }


  @override
  Future<List<String>> getCategories(String userId) async {
    try {
      final response = await _supabaseClient
          .from('products')
          .select('category')
          .eq('user_id', userId);
      final categories = response.map<String>((product) => product['category'] as String).toSet().toList();
      return categories;
    } catch (e) {
      throw Exception('Error getting categories: $e');
    }
  }

}