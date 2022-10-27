import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_demo/user.dart';

class UserScreen extends StatefulWidget {

  final User user;

  const UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Center(child: ClipOval(
                child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover, height: 150, width: 150,),
              ))
            ),
            Container(
              child: Center(
                child: Text(widget.user.name, style: const TextStyle(fontSize: 22, color: Colors.black),),
              ),
            ),
            Container(
              child: Center(
                child: Text(widget.user.city, style: const TextStyle(fontSize: 18, color: Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
