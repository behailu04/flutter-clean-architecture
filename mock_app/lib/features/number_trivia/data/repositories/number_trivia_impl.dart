import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mock_app/core/error/exceptions.dart';
import 'package:mock_app/core/error/failure.dart';
import 'package:mock_app/core/network/network_info.dart';
import 'package:mock_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:mock_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:mock_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mock_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
        return await _getTrivia(() {
          return remoteDataSource.getConcreteNumberTrivia(number);
        });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<NumberTrivia> Function() getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia =
            await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getLastNumberTrivia());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    }
}
