import 'package:hungry/features/home/data/model/toppings_model.dart';

abstract class ToppingsAndOptionsStates {}

class ToppingsAndOptionsInitial extends ToppingsAndOptionsStates {}

class ToppingsAndOptionsLoading extends ToppingsAndOptionsStates {}

class ToppingsAndOptionsSuccess extends ToppingsAndOptionsStates {}

class ToppingsAndOptionsError extends ToppingsAndOptionsStates {
  final String message;
  ToppingsAndOptionsError(this.message);
}
