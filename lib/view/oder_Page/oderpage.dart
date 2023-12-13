import 'package:akij_task/view/oder_Page/ordersuccc.dart';
import 'package:flutter/material.dart';

class Orderpage extends StatefulWidget {
  const Orderpage({super.key});

  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  int quantity = 0;
  List<Map<String, dynamic>> mpList = [];

  Future<void> _showAlertDialog(String shop_name, String productName, Function() updateAppBar) async {
    TextEditingController phoneController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Container(
                height: 30,
                color: Colors.green[100],
                child: Center(
                  child: Text(
                    'Shop Name: ${shop_name}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Items name: ${productName}"),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Phone number: "),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 330.0,
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
                          ),
                          hintText: "Enter your Phone Number ",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 30,
                      color: Colors.green[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quantity"),
                          IconButton(
                            onPressed: () {
                              if (quantity > 0) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: Icon(Icons.remove_circle),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add_box),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (quantity <= 10) {
                          Map<String, dynamic> mp = {};
                          mp['shopName'] = shop_name;
                          mp['productName'] = productName;
                          mp['qty'] = quantity;
                          mp['phone_Number'] = phoneController.text;
                          quantity = 0;
                          mpList.add(mp);
                          setState(() {});
                          updateAppBar(); // Call the callback to update the app bar
                          Navigator.of(context).pop();
                        } else {
                          odershowError();
                          // Handle case when quantity is 0
                        }
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Cancel',
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
        actions: [
          Text(mpList.length.toString()),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                print(mpList);
              },
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return OrderSuccessPage(
                      order: mpList,
                    );
                  }));
                },
                child: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       print(mpList);
            //     },
            //     child: Text("dd")),
            SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: shopData['products'].length,
                  itemBuilder: (BuildContext context, int index) {
                    var product = shopData['products'][index];
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          width: 200,
                          child: Card(
                              color: Colors.amber,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(shopData['shop_name']),
                                  Text(product['item_name']),
                                  Text('Quantity: ${product['quantity']}'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showAlertDialog(
                                            shopData['shop_name'],
                                            product['item_name'],
                                            () {
                                              // Callback function to update app bar
                                              setState(() {});
                                            },
                                          );
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.black,
                                            height: 30,
                                            width: 100,
                                            child: Text(
                                              "Add to cart",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showAlertDialog(
                                              shopData['shop_name'],
                                              product['item_name'],
                                              () {
                                                // Callback function to update app bar
                                                setState(() {});
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.add)),
                                    ],
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  final Map<String, dynamic> shopData = {
    "shop_name": "BestMart",
    "phone_number": "555-1234-5678",
    "products": [
      {"item_name": "Pen", "quantity": 20},
      {"item_name": "Laptop", "quantity": 15},
      {"item_name": "mobile", "quantity": 30},
      {"item_name": "Cable", "quantity": 25},
      {"item_name": "power Bank", "quantity": 10},
      {"item_name": "charger", "quantity": 12},
    ]
  };
  Future<void> odershowError() async {
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
                  child: Text(
                    "Dont add more then 10",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // SizedBox(height: 10),
                    // Container(
                    //   padding: EdgeInsets.only(left: 20, right: 20),
                    //   height: 30,
                    //   color: Colors.green[100],
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [Text("order placed successfully")],
                    //   ),
                    // ),
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
}
