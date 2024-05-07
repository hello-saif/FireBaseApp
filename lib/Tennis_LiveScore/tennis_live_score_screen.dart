// firebase class 3
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TennisLiveScoreScreen extends StatefulWidget {
  const TennisLiveScoreScreen({super.key});

  @override
  State<TennisLiveScoreScreen> createState() => _TennisLiveScoreScreenState();
}

class _TennisLiveScoreScreenState extends State<TennisLiveScoreScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tennis live score'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(24),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: StreamBuilder(
                stream: _firebaseFirestore.collection('tennis').doc('Ban-vs-Pak').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  //print(snapshot.data?.data()); //{player1: 3, player2: 4}
                  final player1Score = snapshot.data?.get('player1')?? '0';
                  final player2Score = snapshot.data?.get('player2')?? '0';
                  return Row(
                  children: [
                    _buildPlayerScore(playerName: 'Player 1', score: player1Score),
                    const SizedBox(height: 40, child: VerticalDivider()),
                    _buildPlayerScore(playerName: 'Player 2', score: player2Score),
                  ],
                );
               },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPlayerScore({required final String playerName, required final String score}){ // method extraction
    return Expanded(
        child: Column(children: [
          Text(score,style: Theme.of(context).textTheme.titleLarge,),
          Text(playerName,style: Theme.of(context).textTheme.titleSmall,),
        ],
        ),
    );
  }
}

