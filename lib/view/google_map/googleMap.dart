import 'package:akij_task/controller/apiRepo.dart';
import 'package:akij_task/view/google_map_page/userdatashow.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

class MapSample extends StatefulWidget {
  @override
  State createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  Location location = Location();
  Completer<GoogleMapController> mapControllerCompleter = Completer();

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  void initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return; // Location service is still not enabled, handle accordingly
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return; // Permission not granted, handle accordingly
      }
    }

    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void onSubmitButtonPressed() {
    if (currentLocation != null) {
      print("Latitudeeeeeeeeeeeee: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}");
    } else {
      print("Location not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapControllerCompleter.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation?.latitude ?? 0.0,
                  currentLocation?.longitude ?? 0.0,
                ),
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              markers: currentLocation != null
                  ? {
                      Marker(
                        markerId: MarkerId("MyLocation"),
                        position: LatLng(
                          currentLocation?.latitude ?? 0.0,
                          currentLocation?.longitude ?? 0.0,
                        ),
                        infoWindow: InfoWindow(title: "My Location"),
                      ),
                    }
                  : {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (currentLocation != null) {
                print("Latitudeeeeeeeeeeeee: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}");
                double? lat = currentLocation!.latitude;
                double? long = currentLocation!.longitude;
                Map a = await Repositores().googleMap(lat!, long!);
                if (a['message'].toString() == 'Data saved successfully') {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return UserDatashow();
                  }));
                }
              } else {
                print("Location not available");
              }
            },
            child: Text("Submit"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapControllerCompleter.future.then((controller) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    currentLocation?.latitude ?? 0.0,
                    currentLocation?.longitude ?? 0.0,
                  ),
                  zoom: 14.0,
                ),
              ),
            );
          });
        },
        child: Icon(Icons.center_focus_strong),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Latitude: ${currentLocation?.latitude ?? 0.0}, Longitude: ${currentLocation?.longitude ?? 0.0}',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
