// firebase class 2 <---------------------
import 'package:app01/Movie_List/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MovieListScreen extends StatefulWidget { // firebase class 2 github code
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}


class _MovieListScreenState extends State<MovieListScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  final List<Movie> movieList =[];
  @override
  void initState() {
    super.initState();
    //FirebaseAuth.getInstance(); // xx
    //_getMovieList(); // <--------- getting problem if initialized here, latter building body.
  }
  // void _getMovieList(){
  //   _firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
  //     //print(value); //Instance of '_JsonQuerySnapshot'
  //     movieList.clear();
  //     for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <---
  //       print(doc.data()); // prints my firestore 'movies' data
  //       movieList.add(
  //           Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),
  //       );
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies class2 -Rafat'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder( // <-----------------
          stream: _firebaseFirestore.collection('movies').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            movieList.clear();
            for (QueryDocumentSnapshot doc in (snapshot.data?.docs ?? [])) {
              movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String, dynamic>),);
            }
            return ListView.separated(
              itemCount: movieList.length,
              //itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movieList[index].name), // snapshot.data!.docs[index].name ?
                  subtitle: Text(movieList[index].languages),
                  leading: Text(movieList[index].rating),
                  trailing: Text(movieList[index].year),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            );
          }
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
                'rating' : '3.4'
              };
              _firebaseFirestore.collection('movies').doc('new-doc-1').set(newMovie);
              // _firebaseFirestore.collection('movies').doc('new-doc-1').update(newMovie);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () {
              _firebaseFirestore.collection('movies').doc('new-doc-1').delete();
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}