import 'package:clean_sample/core/plataform/network_info.dart';
import 'package:clean_sample/features/number_trivia/data/models/datasources/number_trivia_local_data_source.dart';
import 'package:clean_sample/features/number_trivia/data/models/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_sample/features/number_trivia/data/models/repositories/number_trivia_repository_impl.dart';
import 'package:clean_sample/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockremoteDataSource extends Mock implements NumberTriviaRemoteDataSource{

}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource{}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
  NumberTriviaRepositoryImpl repository;
  MockremoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

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
}