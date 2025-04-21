import 'dart:convert';

import 'package:ecommerce_product/Models/product_model.dart';
import 'package:ecommerce_product/constants/base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<ProductModel>>>(
      (ref) => ProductController(),
    );

class ProductController extends StateNotifier<AsyncValue<List<ProductModel>>> {
  ProductController() : super(const AsyncLoading()) {
    fetchProducts();
  }

  int _limit = 5;
  int _page = 1;
  bool _isLoadingMore = false;
  final List<ProductModel> _allProducts = [];
  String _searchQuery = '';

  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=$_limit'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((e) => ProductModel.fromJson(e)).toList();
        _allProducts.addAll(products);
        _page++;
        _updateStateWithSearchFilter();
      } else {
        state = AsyncError('Failed to load products', StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> fetchMore() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=${_page * _limit}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((e) => ProductModel.fromJson(e)).toList();

        if (products.isEmpty) {
          _isLoadingMore = false;
          return;
        }

        _allProducts.clear();
        _allProducts.addAll(products);
        _page++;
        _updateStateWithSearchFilter();
      } else {
        state = AsyncError('Failed to load more products', StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _updateStateWithSearchFilter() {
    final filtered =
        _allProducts.where((product) {
          final title = product.title?.toLowerCase() ?? '';
          return title.contains(_searchQuery.toLowerCase());
        }).toList();
    state = AsyncData(filtered);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _updateStateWithSearchFilter();
  }

  void sortProducts(String type) {
    switch (type) {
      case 'highToLow':
        _allProducts.sort(
          (a, b) => ((b.price ?? 0) as num).compareTo((a.price ?? 0) as num),
        );
        break;
      case 'lowToHigh':
        _allProducts.sort(
          (a, b) => ((a.price ?? 0) as num).compareTo((b.price ?? 0) as num),
        );
        break;
      case 'rating':
        _allProducts.sort(
          (a, b) => ((b.rating!.rate ?? 0) as num).compareTo((a.rating!.rate ?? 0) as num),
        );
        break;
    }
    _updateStateWithSearchFilter();
  }
}
