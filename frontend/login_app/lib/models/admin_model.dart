class AdminModel {
  String username;
  List<dynamic> unverifiedSpots = [];

  AdminModel({required this.username});

  void updateUnverifiedSpots(List<dynamic> spots) {
    unverifiedSpots = spots;
  }
}