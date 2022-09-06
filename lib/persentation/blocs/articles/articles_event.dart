part of 'articles_bloc.dart';

class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class FetchArticles extends ArticlesEvent {
  final String limit;

  const FetchArticles({required this.limit});

  @override
  List<Object> get props => [limit];
}
