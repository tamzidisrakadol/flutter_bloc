import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_details_bloc.dart';

class PostDetailsPage extends StatefulWidget {
  final Product product;

  const PostDetailsPage({super.key, required this.product});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostDetailsBloc>(
      context,
    ).add(GetPostDetailsEvent(product: widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Details Page"),backgroundColor: Colors.green,),
      body: BlocBuilder<PostDetailsBloc, PostDetailsState>(
        builder: (context, state) {
          if (state is PostDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostDetailsLoaded) {
            return Center(
              child: Column(
                children: [
                  Text(state.product.title ?? ""),
                  Text(state.product.category?.name ?? ""),
                ],
              ),
            );
          }else if(state is PostDetailsFailure){
            return Center(child: Text(state.message),);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
