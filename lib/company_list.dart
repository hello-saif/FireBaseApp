// reading nested collection in firestore
import 'package:app01/Movie_List/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});
  static List<Movie> movieList =[];
  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance; // https://firebase.google.com/docs/storage/flutter/start
  final List<Movie> movieList =[];
  //bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) { _getMovieList();});
    _getCompaniesList();
  }

  Future <void> _getCompaniesList()async{ //statically fetch
    //_isLoading=true;
    setState(() {});
    _firebaseFirestore.collection('companies').get().then((value){ // <--- where from ? , class 2, Getting all documents from one collection
      //print(value); //Instance of '_JsonQuerySnapshot'
      // for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <--- //doc: https://firebase.google.com/docs/firestore/quickstart
      //    print(doc.data()); // prints my firestore 'companies' data //ok
      // }
      setState(() {});
    });
    _firebaseFirestore.collection('companies').doc("nAqHfEjZUGGyd1HGFEJ1").collection('workers').get().then((value) {
      print("values = \n$value");
      for(QueryDocumentSnapshot doc in value.docs){ // or var doc, class 2 <--- //doc: https://firebase.google.com/docs/firestore/quickstart
        print("doc.data() = \n${doc.data()}"); //
        Map<dynamic,dynamic> m = doc.data() as Map; // has only 1 entry, if multiple add in a list.
        print(
            "President = ${m["president"]}\n"
            "Engineer = ${m["engineer"]}\n"
            "Ceo= ${m["ceo"]}"
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("company info firestore"),backgroundColor: Colors.blue),
      body: const Column(
        children: [
          Text('testing firestore nested data'),
        ],
      ),
    );
  }
}