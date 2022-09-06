part of 'local_data_bloc.dart';

class LocalDataEvent extends Equatable {
  const LocalDataEvent();

  @override
  List<Object> get props => [];
}

class FetchLocalData extends LocalDataEvent {}

class SubmitLocalData extends LocalDataEvent {
  final String name;
  final String age;

  const SubmitLocalData({required this.age, required this.name});

  @override
  List<Object> get props => [name, age];
}
