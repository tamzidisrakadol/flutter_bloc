import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/CLExample/core/network/api_result.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import '../../../../core/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Product>>> getAllProducts(); //with dartz
  Future<ApiResult<List<Product>>> fetchAllProducts(); //without dartz
}