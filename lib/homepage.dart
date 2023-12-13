import 'package:akij_task/view/QR_page/QRscreen.dart';
import 'package:akij_task/view/google_map/googleMap.dart';
import 'package:akij_task/view/oder_Page/oderpage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return MapSample();
                    }));
                  },
                  child: const Text("Google map")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return QRCodeScnner();
                    }));
                  },
                  child: Text("QR scanner")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return Orderpage();
                    }));
                  },
                  child: Text("Product oder"))
            ],
          ),
        ),
      ),
    );
  }
}
