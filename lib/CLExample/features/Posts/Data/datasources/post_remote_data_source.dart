import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_client.dart';

abstract class PostRemoteDataSource {
  Future<ApiResult<List<Product>>> getAllProducts();
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
}