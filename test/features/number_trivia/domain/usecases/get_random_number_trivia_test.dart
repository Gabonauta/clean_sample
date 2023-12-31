import 'package:clean_sample/core/usecases/usecase.dart';
import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_sample/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_sample/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(
    () {
      mockNumberTriviaRepository = MockNumberTriviaRepository();
      usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
    },
  );
  const tNumberTrivia = NumberTrivia(text: "text", number: 1);
  test("should get trivia from the repository", () async {
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(tNumberTrivia));

    final result = await usecase(NoParams());
    //assert
    expect(
      result,
      Right(tNumberTrivia)
    );
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
