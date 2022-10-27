import 'package:flutter/material.dart';
import 'package:list_demo/rest_api_service.dart';
import 'package:list_demo/user.dart';
import 'package:list_demo/user_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final apiService = RestAPI();
  late List<bool> favouriteStatusList = [];

  @override
  void initState(){
    super.initState();
    apiService.getUsers().then((value){
      if(value.isNotEmpty) {
        for (User user in value) {
          favouriteStatusList.add(false);
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                  future: apiService.getUsers(),
                  builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(
                                    user: snapshot.data![index],
                                  )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        color: Colors.grey.withOpacity(0.3)
                                      )
                                    ]
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: ListTile(
                                    title: Text(snapshot.data![index].name ?? '', style: const TextStyle(fontSize: 22, color: Colors.black),),
                                    subtitle: Text(snapshot.data![index].city ?? '', style: const TextStyle(fontSize: 16, color: Colors.black),),
                                    leading: ClipOval(
                                      child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover, height: 60, width: 60,),
                                    ),
                                    trailing: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            favouriteStatusList[index] = !favouriteStatusList[index];
                                          });
                                        },
                                        icon: getFavouriteIcon(index)),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                      else{
                        return const Center(
                          child: SpinKitFadingCube(
                            color: Colors.blue,
                          ),
                        );
                      }
                  },
                )
            )
          ],
        ),
      ),
    );
  }

  Icon getFavouriteIcon(int index){
    if(favouriteStatusList[index]){
      return const Icon(Icons.favorite, color: Colors.red,);
    }
    else{
      return const Icon(Icons.favorite_border, color: Colors.red,);
    }
  }
}
