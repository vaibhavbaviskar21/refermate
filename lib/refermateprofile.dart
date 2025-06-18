import 'package:flutter/material.dart';

class refermateprofile extends StatelessWidget {
  const refermateprofile({super.key}); // 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              foregroundColor: Colors.amberAccent,
            )
          ]
        ),
      )
    );
  }
}
