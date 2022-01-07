import 'package:doctorcall/features/tracking_feature/models/location_service.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  LocationService locationService = LocationService();
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    locationService.locationStream.listen((locationData) {

      setState(() {
        latitude =  locationData.latitude!;
        longitude = locationData.longitude!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Location Traking"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Latitude: $latitude"),
            Text("Longitude: $longitude")
          ],
        ),
      ),
    );
  }
}
