import 'package:app01/Movie_List/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // -> https://firebase.google.com/docs/firestore/quickstart#dart
import 'package:flutter/material.dart';

class MovieListScreen3 extends StatefulWidget {
  const MovieListScreen3({super.key});
  static List<Movie> movieList =[];
  @override
  State<MovieListScreen3> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen3> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  final List<Movie> movieList =[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies screen3"),backgroundColor: Colors.blue),
      body: StreamBuilder( // <-------- auto updates if updated in Cloud Firestore
        stream: _firebaseFirestore.collection('movies').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          movieList.clear();
          for(QueryDocumentSnapshot doc in (snapshot.data?.docs?? [])){ // or var doc, class 2 <--- //doc: https://firebase.google.com/docs/firestore/quickstart
            movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
          }
          return ListView.separated(
            itemCount: movieList.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(movieList[index].name),
                subtitle: Text(movieList[index].languages),
                leading: Text(movieList[index].rating),
                trailing: Text(movieList[index].year),
              );
            },
            separatorBuilder:(_,__)=> const Divider(),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Map<String, dynamic> newMovie = {
                'name' : 'King kong updated',
                'year' : '1996',
                'languages' : "English, Bengali, Hindi",
                'rating' : '3.5'
              };
              _firebaseFirestore.collection('movies').doc('new-doc-id-1').set(newMovie); // creates new, doc is optional here/ auto set id.
              // _firebaseFirestore.collection('movies').doc('new-doc-1').update(newMovie); // updates
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () {
              _firebaseFirestore.collection('movies').doc('new-doc-id-1').delete();
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}