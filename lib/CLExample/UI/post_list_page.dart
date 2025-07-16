import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/CLExample/bloc/post_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/post_bloc.dart';


class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetAllPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clean Architecture example"),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<PostBloc,PostState>(builder: (context,state){
        if(state is PostInitial){
          return Center(child: CircularProgressIndicator());
        }else if(state is PostLoading){
          return Center(child: CircularProgressIndicator());
        }else if(state is PostLoaded){
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context,index){
              final post = state.posts[index];
              return ListTile(
                title: Text(post.title??""),
                subtitle: Text(post.category?.name ??""),
                onTap: (){
                  /* go and go_named used for screen replacement and navigation
                  * use push and push named for using backstack*/


                  context.push("/details",extra: post);
                },
              );
            },
          );
        }else if(state is PostError){
          return Center(child: Text(state.message,style: TextStyle(color: Colors.red,fontSize: 20),));
        }
        return SizedBox.shrink();
      }),
    );
  }
}
