part of 'articles_bloc.dart';

class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class FetchArticlesLoading extends ArticlesState {}

class FetchArticlesSuccess extends ArticlesState {
  final List<Articles> articles;

  const FetchArticlesSuccess({required this.articles});

  @override
  List<Object> get props => [articles];
}

class FetchArticlesFailed extends ArticlesState {
  final String message;

  const FetchArticlesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
