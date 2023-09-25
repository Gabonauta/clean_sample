import 'package:clean_sample/features/number_trivia/data/models/number_trivia.dart';
import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource{
  ///Gets the cached [NumberTriviaMOdel] wich was gotten the last time the user had an internet connection
  ///
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia triviToCache);
}