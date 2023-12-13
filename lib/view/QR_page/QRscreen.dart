import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class QRCodeScnner extends StatefulWidget {
  // String a = "banglasesh";
  // QRCodeScnner(this.a);
  @override
  _QRCodeScnnerState createState() => _QRCodeScnnerState();
}

class _QRCodeScnnerState extends State<QRCodeScnner> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool camState = false;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> splitParts = _qrInfo!.split('/');
    String code = splitParts.last;
    print(code);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (camState == true) {
      //       setState(() {
      //         camState = false;
      //       });
      //     } else {
      //       setState(() {
      //         camState = true;
      //       });
      //     }
      //   },
      // ),
      body: camState
          ? Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code results :" + code!,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        List<String> splitParts = _qrInfo!.split('/');
                        String code = splitParts.last;
                        print(code);
                        Navigator.of(context).pop();
                      },
                      child: Text("go Back"))
                ],
              ),
            ),
    );
  }
}
