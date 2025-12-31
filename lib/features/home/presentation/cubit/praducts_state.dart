import 'package:hungry/features/home/data/model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  ProductSuccess(this.productModel);
  final List<ProductModel> productModel;
}

class ProductError extends ProductState {
  ProductError(this.message);
  final String message;
}
