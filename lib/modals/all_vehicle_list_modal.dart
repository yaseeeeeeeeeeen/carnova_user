// To parserequired this JSON data, do
//
//     final allVehicle2Modal = allVehicleModalFromJson(jsonString);

import 'dart:convert';

AllVehicleModal allVehicleModalFromJson(String str) {
    final jsonData = json.decode(str);
    return AllVehicleModal.fromJson(jsonData);
}

String allVehicleModalToJson(AllVehicleModal data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class AllVehicleModal {
    List<Vehicle2> vehicles;

    AllVehicleModal({
       required this.vehicles,
    });

    factory AllVehicleModal.fromJson(Map<String, dynamic> json) =>  AllVehicleModal(
        vehicles:  List<Vehicle2>.from(json["vehicles"].map((x) => Vehicle2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vehicles":  List<dynamic>.from(vehicles.map((x) => x.toJson())),
    };
}

class Vehicle2 {
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
    CreatedBy createdBy;
    List<String> images;
    bool isVerified;
    List<dynamic> review;
    int v;
    String document;

    Vehicle2({
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

    factory Vehicle2.fromJson(Map<String, dynamic> json) =>  Vehicle2(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        model: json["createdyear"],
        transmission: json["transmission"],
        brand: json["brand"],
        number: json["number"],
        seat: json["seat"],
        fuel: json["fuel"],
        location: json["location"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        images:  List<String>.from(json["images"].map((x) => x)),
        isVerified: json["isVerified"],
        review:  List<dynamic>.from(json["review"].map((x) => x)),
        v: json["__v"],
        document: json["document"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "createdyear": model,
        "transmission": transmission,
        "brand": brand,
        "number": number,
        "seat": seat,
        "fuel": fuel,
        "location": location,
        "lat": lat,
        "long": long,
        "createdBy": createdBy.toJson(),
        "images":  List<dynamic>.from(images.map((x) => x)),
        "isVerified": isVerified,
        "review":  List<dynamic>.from(review.map((x) => x)),
        "__v": v,
        "document": document,
    };
}

class CreatedBy {
    String id;
    String name;
    String email;
    int phone;
    String password;
    bool isBlocked;
    bool isVerified;
    int v;
    String profile;

    CreatedBy({
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

    factory CreatedBy.fromJson(Map<String, dynamic> json) =>  CreatedBy(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        isBlocked: json["isBlocked"],
        isVerified: json["isVerified"],
        v: json["__v"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "isBlocked": isBlocked,
        "isVerified": isVerified,
        "__v": v,
        "profile": profile,
    };
}
