part of 'miniproject_bloc.dart';

@immutable
abstract class MiniprojectState {}

class MiniprojectInitial extends MiniprojectState {}

class AppLoading extends MiniprojectState{}
class AppLoaded extends MiniprojectState{}
