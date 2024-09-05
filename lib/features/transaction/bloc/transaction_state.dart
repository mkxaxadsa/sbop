part of 'transaction_bloc.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class IncomeLoadedState extends TransactionState {
  final List<Income> incomes;
  final int incomeAmount;
  final int expenseAmount;
  IncomeLoadedState({
    required this.incomes,
    required this.incomeAmount,
    required this.expenseAmount,
  });
}
