import 'package:flutter_b_sm/CLExample/UI/post_details_page.dart';
import 'package:flutter_b_sm/CLExample/UI/post_list_page.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/AuthBloc/auth_bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/MovieBloc/movie_bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/ServiceProviderBloC/service_provider_bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/UI/AddServiceProvider.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/UI/HomePage.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/UI/MoviePage.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/UI/SignUpPage.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/Repositories/SongRepository.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/UseCase/GetLocalSongs.dart';
import 'package:flutter_b_sm/MusicPlayer/presentation/BloC/song_bloc.dart';
import 'package:flutter_b_sm/MusicPlayer/presentation/UI/SongListScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../SampleExample/bloc/ImagePickerBloc/image_picker_bloc.dart';
import '../../SampleExample/bloc/SliderBloc/slider_bloc.dart';
import '../../SampleExample/bloc/Utils/ImagePickerUtils.dart';
import '../../SampleExample/bloc/counterBloc/CounterBloc.dart';
import '../../main.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_details_bloc.dart';
import '../features/Posts/Domain/post.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "home page",
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CounterBloc()),
            BlocProvider(create: (context) => SliderBloc()),
            BlocProvider(
              create: (context) => ImagePickerBloc(ImagePickerUtils()),
            ),
            BlocProvider(create: (context) => sl<PostBloc>()),
            BlocProvider(create: (context) => PostDetailsBloc()),
            BlocProvider(create: (context)=> sl<MusicPlayerBloc>()),
            BlocProvider(create: (context)=> sl<AuthBloc>()),
            BlocProvider(create: (context)=> sl<ServiceProviderBloc>()),
            BlocProvider(create: (context)=> sl<MovieBloc>())
          ],
          child: Homepage(),
        );
      },
    ),


    GoRoute(
      path: "/signUp",
      name: "Sign up screen",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: SignUpPage(),
        );
      },
    ),

    GoRoute(
      path: "/addService",
      name: "Service Provider Screen",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<ServiceProviderBloc>(),
          child: AddServiceProvider(),
        );
      },
    ),



    GoRoute(
      path: "/productList",
      name: "Product list Screen",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<PostBloc>(),
          child: PostListPage(),
        );
      },
    ),

    GoRoute(
      path: "/details",
      name: "Product details Screen",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => PostDetailsBloc(),
          child: PostDetailsPage(product: state.extra as Product),
        );
      },
    ),

    GoRoute(
      path: "/movie",
      name: "Movie List Screen",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<MovieBloc>(),
          child: MovieListScreen(),
        );
      },
    ),
  ],
);
