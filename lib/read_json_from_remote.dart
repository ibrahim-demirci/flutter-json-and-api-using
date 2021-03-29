import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/post.dart';
import 'dart:async';

class RemoteJson extends StatefulWidget {
  @override
  _RemoteJsonState createState() => _RemoteJsonState();
}

class _RemoteJsonState extends State<RemoteJson> {
  Post post1;

  // This method get a http package, then decode the package.body and pass parameter to Post.fromJsonMap
  // Finally return  Post List.

  Future<List<Post>> _getPosts() async {
    var response = await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      // this line for one object in response.body
      // return Post.fromJsonMap(json.decode(response.body));
      return (json.decode(response.body) as List)
          .map((onePostMap) => Post.fromJsonMap(onePostMap))
          .toList();
    } else
      throw Exception("Connection Error ${response.statusCode}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remote API Using"),
      ),
      body: Container(
        child: FutureBuilder(
            future: _getPosts(),
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // you can change this values id, body, title eg.
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].body),
                          leading: CircleAvatar(
                            child: Text(snapshot.data[index].id.toString()),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
