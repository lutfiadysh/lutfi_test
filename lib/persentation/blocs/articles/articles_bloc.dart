import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lutfi_ardiansyah_test/data/entities/articles/articles.dart';
import 'package:lutfi_ardiansyah_test/data/remote_datasource/articles_remote_datasource.dart';
import 'package:lutfi_ardiansyah_test/injection/injection_container.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  var articlesRemoteDatasource = sl<ArticlesRemoteDatasource>();
  ArticlesBloc() : super(ArticlesInitial()) {
    on<FetchArticles>(mapFetchArticlesToState);
  }

  void mapFetchArticlesToState(FetchArticles event, emit) async {
    try {
      final response =
          await articlesRemoteDatasource.fetchArticles(event.limit);

      emit(FetchArticlesSuccess(articles: response));
    } catch (e) {
      emit(FetchArticlesFailed(message: e.toString()));
    }
  }
}
