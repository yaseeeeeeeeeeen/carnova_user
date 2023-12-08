class VehicleDataModal {
  final double rating;
  final String name;
  final String brand;
  final String modal;
  final String vehicleNumber;
  final String fuel;
  final String location;
  final double lat;
  final double long;
  final int seat;
  final String transmission;
  final String price;
  final String coverPhoto;
  final List<String> images;
  VehicleDataModal(
      {required this.rating,
      required this.location,
      required this.lat,
      required this.long,
      required this.seat,
      required this.images,
      required this.coverPhoto,
      required this.name,
      required this.brand,
      required this.modal,
      required this.vehicleNumber,
      required this.fuel,
      required this.transmission,
      required this.price});
  factory VehicleDataModal.fromJson(Map<String, dynamic> data) =>
      VehicleDataModal(
        seat: data["seat"],
          lat: data["lat"],
          long: data["long"],
          location: data["location"],
          rating: data["rating"],
          images: data["vehicleImages"],
          coverPhoto: data["coverPhoto"],
          name: data["name"],
          brand: data["brand"],
          modal: data["modal"],
          vehicleNumber: data["vehicleNumber"],
          fuel: data["fuel"],
          transmission: data["transmission"],
          price: data["price"]);
}

List<VehicleDataModal> vehiclesData = [];
