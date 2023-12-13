import 'package:akij_task/controller/apiRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserDatashow extends StatefulWidget {
  const UserDatashow({super.key});

  @override
  State<UserDatashow> createState() => _UserDatashowState();
}

class _UserDatashowState extends State<UserDatashow> {
  @override
  List<dynamic> posts = [];
  Future<void> usealldata() async {
    Map usedata = await Repositores().userData();
    List response = usedata['data'];
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$usedata");
    setState(() {
      posts.addAll(response);
    });
  }

  void initState() {
    usealldata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        children: [
                          Text("ID: ${posts[index]['id']}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("user_id: ${posts[index]['user_id']}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("lat: ${posts[index]['lat']}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("long: ${posts[index]['long']}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("created_at: ${posts[index]['created_at']}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("updated_at: ${posts[index]['updated_at']}"),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
