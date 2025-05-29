import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco
  final Set<Marker> _markers = {}; // Set to hold markers

  // Method to handle map creation
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarker(_center); // Add a marker on map creation
  }

  // Method to add a marker to the map
  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('center_marker'),
          position: position,
          infoWindow: InfoWindow(title: 'San Francisco'),
        ),
      );
    });
  }

  // Method to move camera to a new position
  void _moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(34.0522, -118.2437)), // Move to Los Angeles
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps Integration')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers, // Set markers on the map
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera, // Call method to move the camera
        tooltip: 'Move Camera',
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
