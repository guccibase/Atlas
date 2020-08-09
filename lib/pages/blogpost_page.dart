import 'package:Atlas/models/BlogPostDetails.dart';
import 'package:Atlas/services/database_service.dart';
import 'package:Atlas/shared/loading.dart';
import 'package:flutter/material.dart';

class BlogPostPage extends StatefulWidget {

  final String userId;
  final String blogPostId;

  BlogPostPage({
    this.userId,
    this.blogPostId
  });

  @override
  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {

  BlogPostDetails blogPostDetails = new BlogPostDetails();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getBlogPostDetails();
  }

  _getBlogPostDetails() async {
    await DatabaseService(uid: widget.userId).getBlogPostDetails(widget.blogPostId).then((res) {
      setState(() {
        blogPostDetails = res;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(blogPostDetails.blogPostTitle),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          children: <Widget>[
            Text(blogPostDetails.blogPostTitle, style: TextStyle(fontSize: 40.0, color: Colors.black, fontWeight: FontWeight.bold)),

            SizedBox(height: 20.0),

            Text('Author - ${blogPostDetails.blogPostAuthor}', style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),

            SizedBox(height: 5.0),

            Text('Email - ${blogPostDetails.blogPostAuthorEmail}', style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),

            SizedBox(height: 5.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Published on - ${blogPostDetails.date}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius:  BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.thumb_up),
                        SizedBox(width: 7.0),
                        Text('32 Likes')
                      ],
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 40.0),

            Text(blogPostDetails.blogPostContent, style: TextStyle(fontSize: 16.0)),
          ],
        )
      ),
    );
  }
}