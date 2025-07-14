import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/CLExample/core/network/dio_client.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/repositories/post_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../Data/datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      final apiResult = await remoteDataSource.getAllProducts();

      return apiResult.when(
            (data, statusCode) => Right(data), // Success case
            (failure, statusCode) => Left(failure), // Failure case
      );
    } else {
      return const Left(NetworkFailure(message: 'No Internet Connection.'));
    }
  }
}