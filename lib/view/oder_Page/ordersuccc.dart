import 'package:flutter/material.dart';

class OrderSuccessPage extends StatefulWidget {
  List order;
  OrderSuccessPage({super.key, required this.order});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  Future<void> _showAlertDialog(List a) async {
    TextEditingController phoneController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Container(
                color: Colors.green[100],
                child: Center(
                  child: Text(a.toString()),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 30,
                      color: Colors.green[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("order placed successfully")],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order page"),
      ),
      body: Column(
        children: [
          SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: widget.order.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = widget.order[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 100,
                        width: 350,
                        child: Card(
                          color: Color.fromRGBO(158, 158, 158, 1),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "ShopName: ${data['shopName']}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Phone: ${data['phone_Number']}",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Items: ${data['productName']}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "QTY: ${data['qty'].toString()}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
          ElevatedButton(
              onPressed: () {
                _showAlertDialog(widget.order);
              },
              child: Text("Oder Submit"))
        ],
      ),
    );
  }
}
