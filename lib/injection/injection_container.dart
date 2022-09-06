import 'package:get_it/get_it.dart';
import 'package:lutfi_ardiansyah_test/injection/features/init_articles_features.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initArticlesFeatures();
}
