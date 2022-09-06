import 'package:lutfi_ardiansyah_test/data/entities/articles/articles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticlesRemoteDatasource {
  Future<List<Articles>> fetchArticles(limit);
}

class ArticlesRemoteDatasourceImpl implements ArticlesRemoteDatasource {
  @override
  Future<List<Articles>> fetchArticles(limit) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_start=0&_limit=" + limit,
        ),
      );
      // print(response.body);

      return List<Articles>.from(
          json.decode(response.body).map((x) => Articles.fromJson(x)));
    } catch (e) {
      print('error ' + e.toString());
      throw (e);
    }
  }
}
