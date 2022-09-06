import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lutfi_ardiansyah_test/data/entities/articles/articles.dart';
import 'package:lutfi_ardiansyah_test/data/remote_datasource/articles_remote_datasource.dart';
import 'package:lutfi_ardiansyah_test/injection/injection_container.dart';
import 'package:lutfi_ardiansyah_test/persentation/blocs/articles/articles_bloc.dart';

import 'package:lutfi_ardiansyah_test/persentation/widget/snackbars/failed_snackbars.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  int _pageSize = 20;
  final PagingController<int, Articles> _pagingController =
      PagingController(firstPageKey: 0);
  var articlesBloc = ArticlesBloc();
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      if (_pageSize < 40) {
        setState(() {
          _pageSize += 10;
        });

        print(_pageSize);

        articlesBloc.add(FetchArticles(limit: _pageSize.toString()));
      } else {
        showFailedSnackbar(context, title: "Anda sudah di record terakhir");
        _pagingController.error = "Anda sudah di record terakhir";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => articlesBloc..add(FetchArticles(limit: "20")),
      child: Scaffold(
        appBar: AppBar(
          title: Text("List Articles"),
        ),
        body: BlocConsumer<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is FetchArticlesSuccess) {
              final nextPageKey = 0 + state.articles.length;
              _pagingController.appendPage(state.articles, nextPageKey);
              final isLastPage = state.articles.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.articles);
              } else {
                final nextPageKey = 0 + state.articles.length;
                _pagingController.appendPage(state.articles, nextPageKey);
              }
            }
          },
          builder: (context, state) {
            // if (state is FetchArticlesLoading) {
            //   return CircularProgressIndicator();
            // }
            if (state is FetchArticlesSuccess) {
              return PagedListView(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Articles>(
                      itemBuilder: (context, item, index) {
                    var idx = index + 1;
                    return Container(
                      margin: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text(idx.toString()),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(item.body),
                      ),
                    );
                  }));
            }
            if (state is FetchArticlesFailed) {
              return Center(
                child: Column(
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        articlesBloc
                            .add(FetchArticles(limit: _pageSize.toString()));
                      },
                      child: Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width - 32, 50)),
                    ),
                  ],
                ),
              );
            }
            return Column();
          },
        ),
      ),
    );
  }
}
