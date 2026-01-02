import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/data/repo/add_to_cart_repo.dart';

class AddToCartUseCase {
  final AddToCartRepo repo;
  AddToCartUseCase(this.repo);

  Future<Either<Failure, AddToCartResponseModel>> call(
    CartRequestModel request,
  ) async => await repo.addToCart(request);
}
