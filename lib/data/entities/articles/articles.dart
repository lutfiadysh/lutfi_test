import 'package:freezed_annotation/freezed_annotation.dart';

part 'articles.g.dart';
part 'articles.freezed.dart';

@freezed
class Articles with _$Articles {
  factory Articles({
    required String userId,
    required String id,
    required String title,
    required String body,
  }) = _Articles;

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
}
