import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/space_owner_model.dart';

class SpaceOwnerController {
  Future<void> submitParkingSpot(SpaceOwnerModel model) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/add_parking_spot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'spot_id': model.spotId,
          'gps_coordinates': model.gpsCoordinates,
          'address': model.address,
          'pricing': model.pricing,
          'availability_status': true,
          'ev_charging_availability': model.evCharging,
          'surveillance_availability': model.surveillance,
        }),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to submit parking spot');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}