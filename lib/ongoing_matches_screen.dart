// firebase class 3
import 'package:app01/Tennis_LiveScore/tennis_live_score_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OngoingMatchesScreen extends StatefulWidget {
  const OngoingMatchesScreen({super.key});

  @override
  State<OngoingMatchesScreen> createState() => _OngoingMatchesScreenState();
}

class _OngoingMatchesScreenState extends State<OngoingMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ongoing matches'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tennis').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data?.docs.length??0,
            itemBuilder: (context,index){
              DocumentSnapshot doc= snapshot.data!.docs[index];
              return ListTile(
                title: Text(doc.get('name')),
                subtitle: Text(doc.id),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>
                              TennisLiveScoreScreen2(docId: doc.id),
                      ),
                  );
                },
              );
            },
            separatorBuilder: (_,__)=> const Divider(),
          );
        },

      ),
    );
  }
}
