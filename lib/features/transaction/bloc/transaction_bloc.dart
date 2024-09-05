import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/db.dart';
import '../../../core/models/income.dart';
import '../../../core/utils.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<GetIncomesEvent>((event, emit) async {
      if (incomesList.isEmpty) {
        await getIncomes();

        emit(IncomeLoadedState(
          incomes: incomesList,
          incomeAmount: getAmount(true),
          expenseAmount: getAmount(false),
        ));
      } else {
        emit(IncomeLoadedState(
          incomes: incomesList,
          incomeAmount: getAmount(true),
          expenseAmount: getAmount(false),
        ));
      }
    });

    on<AddIncomeEvent>((event, emit) async {
      incomesList.add(event.income);
      await updateIncomes();

      emit(IncomeLoadedState(
        incomes: incomesList,
        incomeAmount: getAmount(true),
        expenseAmount: getAmount(false),
      ));
    });

    on<EditIncomeEvent>((event, emit) async {
      for (Income income in incomesList) {
        if (income.id == event.income.id) {
          income.isIncome = event.income.isIncome;
          income.amount = event.income.amount;
          income.date = event.income.date;
          income.category = event.income.category;
        }
      }
      await updateIncomes();

      emit(IncomeLoadedState(
        incomes: incomesList,
        incomeAmount: getAmount(true),
        expenseAmount: getAmount(false),
      ));
    });

    on<DeleteIncomeEvent>((event, emit) async {
      incomesList.removeWhere((element) => element.id == event.id);
      await updateIncomes();

      emit(IncomeLoadedState(
        incomes: incomesList,
        incomeAmount: getAmount(true),
        expenseAmount: getAmount(false),
      ));
    });
  }
}
