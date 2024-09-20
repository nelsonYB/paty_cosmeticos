import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';

class InventoryRepositoryImpl {
  final SupabaseClient _supabaseClient;

  InventoryRepositoryImpl(this._supabaseClient);

  Future<List<Product>> getProducts() async {
    try {
      final data = await _supabaseClient.from('products').select();

      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  Future<void> createProduct(Product product) async {

    try {
      await _supabaseClient.from('products').insert(product.toJson());
    } catch (e) {
      throw Exception('Error creating product: $e');
    }

  }

}