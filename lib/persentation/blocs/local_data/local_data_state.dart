part of 'local_data_bloc.dart';

class LocalDataState extends Equatable {
  const LocalDataState();

  @override
  List<Object> get props => [];
}

class LocalDataInitial extends LocalDataState {}

class FetchLocalDataLoading extends LocalDataState {}

class FetchLocalDataSuccess extends LocalDataState {
  final List<LocalData> localData;

  const FetchLocalDataSuccess({required this.localData});

  @override
  List<Object> get props => [localData];
}

class FetchLocalDataFailure extends LocalDataState {
  final String message;

  const FetchLocalDataFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class SubmitLocalDataSuccess extends LocalDataState {}

class SubmitLocalDataFailure extends LocalDataState {
  final String message;

  const SubmitLocalDataFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class SubmitLocalDataLoading extends LocalDataState {}
