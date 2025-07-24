import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/CLExample/Router/Navigation.dart';
import 'package:flutter_b_sm/CLExample/UI/post_list_page.dart';
import 'package:flutter_b_sm/CLExample/bloc/post_bloc.dart';
import 'package:flutter_b_sm/CLExample/core/network/dio_client.dart';
import 'package:flutter_b_sm/CLExample/core/network/network_info.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/repositories/post_repository.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/usecases/get_all_posts.dart';
import 'package:flutter_b_sm/FirebaseExample/core/network/firebase_network_info.dart';
import 'package:flutter_b_sm/FirebaseExample/features/data/DataSource/AuthRemoteDataSource.dart';
import 'package:flutter_b_sm/FirebaseExample/features/data/DataSource/ServiceProviderDataSource.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Repository/AuthRepository.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/AuthBloc/auth_bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/MovieBloc/movie_bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/ServiceProviderBloC/service_provider_bloc.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/Repositories/SongRepository.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/UseCase/GetLocalSongs.dart';
import 'package:flutter_b_sm/SampleExample/UI/CounterPage.dart';
import 'package:flutter_b_sm/SampleExample/bloc/ImagePickerBloc/image_picker_bloc.dart';
import 'package:flutter_b_sm/SampleExample/bloc/SliderBloc/slider_bloc.dart';
import 'package:flutter_b_sm/SampleExample/bloc/Utils/ImagePickerUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'CLExample/features/Posts/Data/datasources/post_remote_data_source.dart';
import 'CLExample/features/Posts/Domain/repositories/post_repository_impl.dart';
import 'MusicPlayer/data/DataSource/LocalSongDataSource.dart';
import 'MusicPlayer/domain/UseCase/RequestPermissions.dart';
import 'MusicPlayer/notification/AudioNotificationHandler.dart';
import 'MusicPlayer/presentation/BloC/song_bloc.dart';
import 'SampleExample/bloc/counterBloc/CounterBloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// GetIt instance
final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependency();
  await Firebase.initializeApp();

  // final audioHandler = await AudioService.init(
  //   builder: () => AudioNotificationHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.yourcompany.audio',
  //     androidNotificationChannelName: 'Music playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: goRouter,
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
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(remoteDataSource: sl()));
  sl.registerFactory(()=> PostBloc(sl(),sl()));
  sl.registerFactory<MusicPlayerLocalDataSource>(()=> MusicPlayerLocalDataSourceImpl());
  sl.registerLazySingleton<MusicPlayerRepository>(()=> MusicPlayerRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton(()=> GetSongs(sl()));
  //sl.registerLazySingleton(()=> RequestPermissions(sl()));
  sl.registerFactory(()=> MusicPlayerBloc(getSongs: sl()));
 // sl.registerLazySingleton(()=> AudioNotificationHandler());

  sl.registerLazySingleton<FirebaseNetworkInfo>(()=>FirebaseNetworkInfoImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<ServiceProviderDataSource>(()=>ServiceProviderDataSourceImpl());
  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(sl(),sl()));
  sl.registerLazySingleton(()=>AuthBloc(sl()));
  sl.registerLazySingleton(()=>ServiceProviderBloc(sl()));
  sl.registerLazySingleton(()=>MovieBloc(sl()));
}

