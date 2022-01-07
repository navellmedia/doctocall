import 'package:doctorcall/features/location_feature/models/location_service.dart';
import 'package:doctorcall/features/location_feature/models/user_location.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationService locationService = LocationService();
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    locationService.locationStream.listen((usrData) {
      setState(() {
        latitude =  usrData.latitude!;
        longitude = usrData.longitude!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    //locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location Data"),
        ),
        body: Text("Lat: ${latitude} Long: ${longitude}"));
  }
}
