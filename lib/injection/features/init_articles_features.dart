import 'package:lutfi_ardiansyah_test/data/remote_datasource/articles_remote_datasource.dart';
import 'package:lutfi_ardiansyah_test/injection/injection_container.dart';

void initArticlesFeatures() {
  sl.registerLazySingleton<ArticlesRemoteDatasource>(
      () => ArticlesRemoteDatasourceImpl());
}
