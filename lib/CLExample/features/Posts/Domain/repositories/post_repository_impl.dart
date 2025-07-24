import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/CLExample/core/network/api_result.dart';
import 'package:flutter_b_sm/CLExample/core/network/dio_client.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/repositories/post_repository.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/MovieEntity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../Data/datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    final apiResult = await remoteDataSource.getAllProducts();
    return apiResult.when(
          (data, statusCode) => Right(data), // Success case
          (failure, statusCode) => Left(failure), // Failure case
    );
  }

  //without dartz
  @override
  Future<ApiResult<List<Product>>> fetchAllProducts() async {
    final response = await remoteDataSource.getAllProducts();
    return response.when(
      (data, success) => ApiSuccess(data, statusCode: success),
      (failure, statusCode) => ApiFailure(failure),
    );
  }

  @override
  Future<Either<Failure, Movie>> getAllMovie(int currentPage) async{
    final response = await remoteDataSource.getAllMovies(currentPage);
    return response.when(
      (data, success) => Right(data),
      (failure, statusCode) => Left(failure),
    );
  }
}
