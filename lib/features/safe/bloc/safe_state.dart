part of 'safe_bloc.dart';

abstract class SafeState {}

class SafeInitial extends SafeState {}

class SafeLoadedState extends SafeState {
  final List<Safe> safes;
  SafeLoadedState({required this.safes});
}
