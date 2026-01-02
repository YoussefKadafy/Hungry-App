import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';
import 'package:hungry/features/home/domain/repo/base_home_repo.dart';

class ToppingsAndOptionsUseCase {
  final BaseHomeRepo repo;

  ToppingsAndOptionsUseCase(this.repo);

  Future<Either<Failure, List<ToppingsModel>>> fetchToppings() =>
      repo.fetchToppings();

  Future<Either<Failure, List<ToppingsModel>>> fetchSideOptions() =>
      repo.fetchSideOptions();
}
