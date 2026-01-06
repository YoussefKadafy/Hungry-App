abstract class SaveOrderStates {}

class SaveOrderInitial extends SaveOrderStates {}

class SaveOrderSuccess extends SaveOrderStates {
  final String message;

  SaveOrderSuccess({required this.message});
}

class SaveOrderError extends SaveOrderStates {
  final String message;

  SaveOrderError({required this.message});
}

class SaveOrderLoading extends SaveOrderStates {}
