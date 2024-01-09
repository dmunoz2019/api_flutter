import 'package:flutter/material.dart';
import 'package:project_0/models/post.dart';
import 'package:project_0/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  // Fetch posts from the remote service
  Future<void> getPosts() async {
    try {
      var fetchedPosts = await RemoteService.fetchPosts();
      if (mounted) {
        setState(() {
          posts = fetchedPosts;
          isLoaded = true;
        });
      }
    } catch (e) {
      // Handle the error or show an error message
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: posts?.length ?? 0,
              itemBuilder: (context, index) {
                final post = posts?[index];
                return ListTile(
                  title: Text(post?.title ?? 'No Title'),
                  subtitle: Text(post?.body ?? ''),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
