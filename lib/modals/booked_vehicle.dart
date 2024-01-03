// To parse this JSON data, do
//
//     final bookedVehicle = bookedVehicleFromJson(jsonString);

import 'dart:convert';

BookedVehicle bookedVehicleFromJson(String str) {
    final jsonData = json.decode(str);
    return BookedVehicle.fromJson(jsonData);
}



class BookedVehicle {
    String id;
    String userId;
    VehicleId vehicleId;
    String startDate;
    String endDate;
    String pickup;
    String dropoff;
    int total;
    int grandTotal;
    String status;
    int v;

    BookedVehicle({
       required this.id,
       required this.userId,
       required this.vehicleId,
       required this.startDate,
       required this.endDate,
       required this.pickup,
       required this.dropoff,
       required this.total,
       required this.grandTotal,
       required this.status,
       required this.v,
    });

    factory BookedVehicle.fromJson(Map<String, dynamic> json) =>  BookedVehicle(
        id: json["_id"],
        userId: json["userId"],
        vehicleId: VehicleId.fromJson(json["vehicleId"]),
        startDate: json["startDate"],
        endDate: json["endDate"],
        pickup: json["pickup"],
        dropoff: json["dropoff"],
        total: json["total"],
        grandTotal: json["grandTotal"],
        status: json["status"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "vehicleId": vehicleId.toJson(),
        "startDate": startDate,
        "endDate": endDate,
        "pickup": pickup,
        "dropoff": dropoff,
        "total": total,
        "grandTotal": grandTotal,
        "status": status,
        "__v": v,
    };
}

class VehicleId {
    String id;
    String name;
    int price;
    int model;
    String transmission;
    String brand;
    String number;
    int seat;
    String fuel;
    String location;
    double lat;
    double long;
    String createdBy;
    List<String> images;
    bool isVerified;
    List<dynamic> review;
    int v;
    String document;

    VehicleId({
       required this.id,
       required this.name,
       required this.price,
       required this.model,
       required this.transmission,
       required this.brand,
       required this.number,
       required this.seat,
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
    });

    factory VehicleId.fromJson(Map<String, dynamic> json) =>  VehicleId(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        model: json["model"],
        transmission: json["transmission"],
        brand: json["brand"],
        number: json["number"],
        seat: json["seat"],
        fuel: json["fuel"],
        location: json["location"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        createdBy: json["createdBy"],
        images: new List<String>.from(json["images"].map((x) => x)),
        isVerified: json["isVerified"],
        review: new List<dynamic>.from(json["review"].map((x) => x)),
        v: json["__v"],
        document: json["document"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "model": model,
        "transmission": transmission,
        "brand": brand,
        "number": number,
        "seat": seat,
        "fuel": fuel,
        "location": location,
        "lat": lat,
        "long": long,
        "createdBy": createdBy,
        "images": new List<dynamic>.from(images.map((x) => x)),
        "isVerified": isVerified,
        "review": new List<dynamic>.from(review.map((x) => x)),
        "__v": v,
        "document": document,
    };
}
