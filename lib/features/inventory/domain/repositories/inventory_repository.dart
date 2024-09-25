import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';

abstract class InventoryRepository {
  Future<List<Product>> getProducts();
  Future<void> createProduct(Product product);
  Future<List<String>> getCategories();
}