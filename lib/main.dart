import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/CLExample/UI/post_list_page.dart';
import 'package:flutter_b_sm/CLExample/bloc/post_bloc.dart';
import 'package:flutter_b_sm/CLExample/core/network/dio_client.dart';
import 'package:flutter_b_sm/CLExample/core/network/network_info.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/repositories/post_repository.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/usecases/get_all_posts.dart';
import 'package:flutter_b_sm/SampleExample/UI/CounterPage.dart';
import 'package:flutter_b_sm/SampleExample/bloc/ImagePickerBloc/image_picker_bloc.dart';
import 'package:flutter_b_sm/SampleExample/bloc/SliderBloc/slider_bloc.dart';
import 'package:flutter_b_sm/SampleExample/bloc/Utils/ImagePickerUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'CLExample/features/Posts/Data/datasources/post_remote_data_source.dart';
import 'CLExample/features/Posts/Domain/repositories/post_repository_impl.dart';
import 'SampleExample/bloc/counterBloc/CounterBloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// GetIt instance
final sl = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterBloc()),
          BlocProvider(create: (context) => SliderBloc()),
          BlocProvider(create: (context) => ImagePickerBloc(ImagePickerUtils())),
          BlocProvider(create: (context) => sl<PostBloc>()),
        ],
        child: const PostListPage(),
      ),
    );
  }
}

void initDependency(){
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(()=>DioClient(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerSingleton(()=> GetAllPosts(sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(dioClient: sl()));
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));
  sl.registerFactory(()=> PostBloc(sl()));
}

