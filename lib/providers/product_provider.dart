import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => [..._products];
  List<String> get categories => [..._categories];
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
      _categories = await _apiService.getCategories();
    } catch (error) {
      _error = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category) {
    if (category == 'All') {
      return products;
    }
    return products.where((product) => product.category == category).toList();
  }
}