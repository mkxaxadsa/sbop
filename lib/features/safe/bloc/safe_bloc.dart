import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/db.dart';
import '../../../core/models/safe.dart';

part 'safe_event.dart';
part 'safe_state.dart';

class SafeBloc extends Bloc<SafeEvent, SafeState> {
  SafeBloc() : super(SafeInitial()) {
    on<GetSafesEvent>((event, emit) async {
      if (safesList.isEmpty) {
        await getSafes();

        emit(SafeLoadedState(safes: safesList));
      } else {
        emit(SafeLoadedState(safes: safesList));
      }
    });

    on<AddSafeEvent>((event, emit) async {
      safesList.add(event.safe);
      await updateSafes();

      emit(SafeLoadedState(safes: safesList));
    });

    on<EditSafeEvent>((event, emit) async {
      for (Safe safe in safesList) {
        if (safe.id == event.safe.id) {
          safe.title = event.safe.title;
          safe.amount = event.safe.amount;
          safe.deadline = event.safe.deadline;
        }
      }
      await updateSafes();

      emit(SafeLoadedState(safes: safesList));
    });

    on<DeleteSafeEvent>((event, emit) async {
      safesList.removeWhere((element) => element.id == event.id);
      await updateSafes();

      emit(SafeLoadedState(safes: safesList));
    });
  }
}
