import 'package:flutter_b_sm/CLExample/UI/post_details_page.dart';
import 'package:flutter_b_sm/CLExample/UI/post_list_page.dart';
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
      name: "Product List Screen",
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
          ],
          child: const PostListPage(),
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
  ],
);
