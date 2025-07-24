import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/MovieEntity.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_client.dart';

abstract class PostRemoteDataSource {
  Future<ApiResult<List<Product>>> getAllProducts();
  Future<ApiResult<Movie>> getAllMovies(int currentPage);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;

  PostRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<ApiResult<List<Product>>> getAllProducts() async {
    return await dioClient.apiResponseHandler<List<Product>>(
      "api/v1/products", // Just the endpoint path
      method: 'GET',
      parser: (json) {
        final List<dynamic> jsonList = json;
        return jsonList.map((item) => Product.fromJson(item)).toList();
      },
    );
  }

  @override
  Future<ApiResult<Movie>> getAllMovies(int currentPage) {
    return dioClient.apiResponseHandler<Movie>(
      "v3/feed/new-arrivals", // Just the endpoint path
      method: 'GET',
      queryParameters: {
        'page': currentPage,
      },
      parser: (json){
        return Movie.fromJson(json);
      }
    );
  }
}