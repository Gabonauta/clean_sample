

import 'package:clean_sample/core/error/exceptions.dart';
import 'package:clean_sample/core/error/failure.dart';
import 'package:clean_sample/core/plataform/network_info.dart';
import 'package:clean_sample/features/number_trivia/data/models/datasources/number_trivia_local_data_source.dart';
import 'package:clean_sample/features/number_trivia/data/models/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_sample/features/number_trivia/data/models/number_trivia.dart';
import 'package:clean_sample/features/number_trivia/data/models/repositories/number_trivia_repository_impl.dart';
import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockremoteDataSource extends Mock implements NumberTriviaRemoteDataSource{

}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource{}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
  late MockNetworkInfo mockNetworkInfo;
  late NumberTriviaRepositoryImpl repository;
  late MockremoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockremoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body){
    group("device is online", () { 
      setUp(() {
        when(mockNetworkInfo.isConected).thenAnswer((realInvocation) async=> true);
      });
      body();
    });
  }
  void runTestOffline(Function body){
    group("device is offline", () { 
      setUp(() {
        when(mockNetworkInfo.isConected).thenAnswer((realInvocation) async=> false);
      });
      body();
    });
  }
  group("getConcreteNumberTriviaRepo", () { 

      final tNumber = 1;
      
      final tNumberTriviaModel = NumberTriviaModel(text: "test trivia", number: tNumber);
      final NumberTrivia tNumberTrivia = tNumberTriviaModel;
      test('should check if the device is online', () async {
        //arrange
        when(mockNetworkInfo.isConected).thenAnswer((realInvocation) async => true);
        //act
        repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockNetworkInfo.isConected);

      },);
      runTestOnline( () {
        

        test("should remote data when the call to remote data source is successful", () async {
          
          //arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_)  async => tNumberTriviaModel);
          //act
          final result = 
          await repository.getConcreteNumberTrivia(tNumber);
          //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
            expect(result, equals(Right(tNumberTrivia)));
                  });
            test("should cache data locally when the call to remote data source is successful", () async {
          
          //arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((realInvocation)  async{
            return tNumberTriviaModel;
          },);
          //act
          await repository.getConcreteNumberTrivia(tNumber);
          //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
                  });
          test("should server failure when the call to remote data source is unsuccessful", () async {
          
          //arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());
          //act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
            expect(result, equals(Left(ServerFailure())));
            verifyZeroInteractions(mockLocalDataSource);
                  });
                });
runTestOffline( () {
 

  test(
    'should return last locally cached data when the cached data is present',
    () async {
      // arrange
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Right(tNumberTrivia)));
    },
  );
  test(
  'should return CacheFailure when there is no cached data present',
  () async {
    // arrange
    when(mockLocalDataSource.getLastNumberTrivia())
        .thenThrow(CacheException());
    // act
    final result = await repository.getConcreteNumberTrivia(tNumber);
    // assert
    verifyZeroInteractions(mockRemoteDataSource);
    verify(mockLocalDataSource.getLastNumberTrivia());
    expect(result, equals(Left(CacheFailure())));
  },
);

 });
  });
  group("getRandomNumberTriviaRepo", () { 

      const  tNumber = 1;
      
      final tNumberTriviaModel = NumberTriviaModel(text: "test trivia", number: tNumber);
      final NumberTrivia tNumberTrivia = tNumberTriviaModel;
      test('should check if the device is online', () async {
        //arrange
        when(mockNetworkInfo.isConected).thenAnswer((realInvocation) async => true);
        //act
        repository.getRandomNumberTrivia();
        //assert
        verify(mockNetworkInfo.isConected);

      },);
      runTestOnline( () {
        

        test("should remote data when the call to remote data source is successful", () async {
          
          //arrange
          when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_)  async => tNumberTriviaModel);
          //act
          final result = 
          await repository.getRandomNumberTrivia();
          //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
            expect(result, equals(Right(tNumberTrivia)));
                  });
            test("should cache data locally when the call to remote data source is successful", () async {
          
          //arrange
          when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((realInvocation)  async{
            return tNumberTriviaModel;
          },);
          //act
          await repository.getRandomNumberTrivia();
          //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
                  });
          test("should server failure when the call to remote data source is unsuccessful", () async {
          
          //arrange
          when(mockRemoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());
          //act
          final result = await repository.getRandomNumberTrivia();
          //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
            
            expect(result, equals(Left(ServerFailure())));
            verifyZeroInteractions(mockLocalDataSource);
                  });
                });
runTestOffline( () {
 

  test(
    'should return last locally cached data when the cached data is present',
    () async {
      // arrange
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Right(tNumberTrivia)));
    },
  );
  test(
  'should return CacheFailure when there is no cached data present',
  () async {
    // arrange
    when(mockLocalDataSource.getLastNumberTrivia())
        .thenThrow(CacheException());
    // act
    final result = await repository.getRandomNumberTrivia();
    // assert
    verifyZeroInteractions(mockRemoteDataSource);
    verify(mockLocalDataSource.getLastNumberTrivia());
    expect(result, equals(Left(CacheFailure())));
  },
);

 });
  });
}