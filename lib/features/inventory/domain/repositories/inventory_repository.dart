import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';

abstract class InventoryRepository {
  Future<List<Product>> getProducts(String userId);
  Future<void> createProduct(Product product);
  Future<List<String>> getCategories(String userId);
}