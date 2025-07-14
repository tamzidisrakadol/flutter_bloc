import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/CLExample/core/error/failure.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import '../repositories/post_repository.dart';

class GetAllPosts {
  final PostRepository repository;

  GetAllPosts(this.repository);

  // This use case doesn't require any parameters
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}