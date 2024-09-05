part of 'transaction_bloc.dart';

abstract class TransactionEvent {}

class GetIncomesEvent extends TransactionEvent {}

class AddIncomeEvent extends TransactionEvent {
  final Income income;
  AddIncomeEvent({required this.income});
}

class EditIncomeEvent extends TransactionEvent {
  final Income income;
  EditIncomeEvent({required this.income});
}

class DeleteIncomeEvent extends TransactionEvent {
  final int id;
  DeleteIncomeEvent({required this.id});
}
