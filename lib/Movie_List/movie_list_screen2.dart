import 'package:app01/Movie_List/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';

class MovieListScreen2 extends StatefulWidget { /// up to 40:16 of firebase class 2 video
  const MovieListScreen2({super.key});
  static List<Movie> movieList =[];
  @override
  State<MovieListScreen2> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen2> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  final List<Movie> movieList =[];
  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) { _getMovieList();});
    _getMovieList();
  }
  //void _getMovieList(){
  Future <void> _getMovieList()async{ //statically fetch
    _isLoading=true;
    setState(() {});
    //await Future.delayed(Duration.zero); // <--- Add a 0 dummy waiting time, write inside build ?
    _firebaseFirestore.collection('movies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
      //print(value); //Instance of '_JsonQuerySnapshot'
      movieList.clear();
      for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <--- //doc: https://firebase.google.com/docs/firestore/quickstart
        //print(doc.data()); // prints my firestore 'movies' data //ok
        movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String,dynamic>),);
      }
      //print("movieList length = ${movieList.length}"); //ok
      //print("name[0]=${movieList[0].name}"); //ok
      _isLoading=false;
      setState(() {}); // at 40:25 of class 2 video, works without setState
    });
  }

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getMovieList()); // error: getting continuous call to _getMovieList()
    //SchedulerBinding.instance.addPostFrameCallback((_) {_getMovieList();}); // ^ same
    return Scaffold(
      appBar: AppBar(title: const Text("Movies screen2"),backgroundColor: Colors.blue),
      body: SizedBox(
        child: Visibility(
          visible: _isLoading==false,
          replacement: const Center(child: CircularProgressIndicator(),),
          child: ListView.separated(
            itemCount: movieList.length, // <--- empty list?
            itemBuilder: (context,index){
              return ListTile(
                title: Text(movieList[index].name),
                subtitle: Text(movieList[index].languages),
                leading: Text(movieList[index].rating),
                trailing: Text(movieList[index].year),
              );
            },
            separatorBuilder:(_,__)=> const Divider(),
          ),
        ),
      ),
    );
  }
}