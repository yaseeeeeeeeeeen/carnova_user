class HostDetails {
  String id;
  String name;
  String email;
  int phone;
  String password;
  bool isBlocked;
  bool isVerified;
  int v;
  String profile;

  HostDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.isBlocked,
    required this.isVerified,
    required this.v,
    required this.profile,
  });

  factory HostDetails.fromJson(Map<String, dynamic> json) {
    return HostDetails(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      isBlocked: json['isBlocked'],
      isVerified: json['isVerified'],
      v: json['__v'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'isBlocked': isBlocked,
      'isVerified': isVerified,
      '__v': v,
      'profile': profile,
    };
  }
}

class BookingModel {
  String id;
  String userId;
  Vehicle vehicle;
  String startDate;
  String endDate;
  String pickup;
  String dropoff;
  double total;
  double grandTotal;
  String status;
  String razorId;
  int v;

  BookingModel({
    required this.id,
    required this.userId,
    required this.vehicle,
    required this.startDate,
    required this.endDate,
    required this.pickup,
    required this.dropoff,
    required this.total,
    required this.grandTotal,
    required this.status,
    required this.razorId,
    required this.v,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      userId: json['userId'],
      vehicle: Vehicle.fromJson(json['vehicleId']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      pickup: json['pickup'],
      dropoff: json['dropoff'],
      total: json['total'].toDouble(),
      grandTotal: json['grandTotal'].toDouble(),
      status: json['status'],
      razorId: json['razorId'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'vehicleId': vehicle.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'pickup': pickup,
      'dropoff': dropoff,
      'total': total,
      'grandTotal': grandTotal,
      'status': status,
      'razorId': razorId,
      '__v': v,
    };
  }
}

class Vehicle {
  String id;
  String name;
  double price;
  int model;
  String transmission;
  String brand;
  String fuel;
  String location;
  double lat;
  double long;
  String createdBy;
  List<String> images;
  bool isVerified;
  List<String> review;
  int v;
  String document;
  // List<String> bookings;
  HostDetails hostDetails; // Add hostDetails field

  Vehicle({
    required this.id,
    required this.name,
    required this.price,
    required this.model,
    required this.transmission,
    required this.brand,
    required this.fuel,
    required this.location,
    required this.lat,
    required this.long,
    required this.createdBy,
    required this.images,
    required this.isVerified,
    required this.review,
    required this.v,
    required this.document,
    // required this.bookings,
    required this.hostDetails,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      model: json['model'],
      transmission: json['transmission'],
      brand: json['brand'],
      fuel: json['fuel'],
      location: json['location'],
      lat: json['lat'],
      long: json['long'],
      createdBy: json['createdBy'],
      images: List<String>.from(json['images']),
      isVerified: json['isVerified'],
      review: List<String>.from(json['review']),
      v: json['__v'],
      document: json['document'],
      // bookings: List<String>.from(json['bookings']),
      hostDetails: HostDetails.fromJson(json['hostDetails'][0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'model': model,
      'transmission': transmission,
      'brand': brand,
      'fuel': fuel,
      'lat':lat,
      'long':long,
      'location': location,
      'createdBy': createdBy,
      'images': images,
      'isVerified': isVerified,
      'review': review,
      '__v': v,
      'document': document,
      // 'bookings': bookings,
      'hostDetails': hostDetails.toJson(),
       // Add this line
    };
  }
}
