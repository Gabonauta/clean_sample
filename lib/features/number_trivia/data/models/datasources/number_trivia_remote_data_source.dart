
import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource{
   Future<NumberTrivia> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}