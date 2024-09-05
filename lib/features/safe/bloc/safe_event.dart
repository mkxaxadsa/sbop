part of 'safe_bloc.dart';

abstract class SafeEvent {}

class GetSafesEvent extends SafeEvent {}

class AddSafeEvent extends SafeEvent {
  final Safe safe;
  AddSafeEvent({required this.safe});
}

class EditSafeEvent extends SafeEvent {
  final Safe safe;
  EditSafeEvent({required this.safe});
}

class DeleteSafeEvent extends SafeEvent {
  final int id;
  DeleteSafeEvent({required this.id});
}
