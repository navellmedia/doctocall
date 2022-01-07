import 'dart:async';

import 'package:doctorcall/features/location_feature/models/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    //location.enableBackgroundMode(enable: true);
    try{
      location.requestPermission().then((permitionStatus) {
        if (permitionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen((locationData) {
            if (locationData != null) {
              print("${locationData.latitude}");
              _locationStreamController.add(UserLocation(
                  latitude: locationData.latitude,
                  longitude: locationData.longitude));
            }
          });
        }
      });
    }catch(e){

    }
  }

  void dispose() => _locationStreamController.close();

}
