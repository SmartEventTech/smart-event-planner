class EventModel {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final String? status;
  final String? hostCompany;
  final String? isRecurring;
  final DateTime? date;
  final String? time;
  final String? price;
  final String? type;
  final bool? paid;
  final String? host;
  final List<dynamic>? attendees;
  final LocationModel? location;
  final int? v;
  final String? imageUrl; 

  EventModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.status,
    this.hostCompany,
    this.isRecurring,
    this.date,
    this.time,
    this.price,
    this.type,
    this.paid,
    this.host,
    this.attendees,
    this.location,
    this.v,
    this.imageUrl, 
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    try {
      DateTime? parsedDate;
      if (json['date'] != null) {
        if (json['date'] is DateTime) {
          parsedDate = json['date'];
        } else if (json['date'] is String) {
          parsedDate = DateTime.tryParse(json['date']);
        }
      }

      LocationModel? location;
      if (json['location'] != null && json['location'] is Map) {
        try {
          location = LocationModel.fromJson(json['location']);
        } catch (e) {
          rethrow;
        }
      }

      List<dynamic>? attendees;
      if (json['attendees'] != null && json['attendees'] is List) {
        attendees = List<dynamic>.from(json['attendees']);
      }

      String? imageUrl;
      if (json['imageUrl'] != null) {
        imageUrl = json['imageUrl'].toString();
      } else if (json['image'] != null) {
        imageUrl = json['image'].toString();
      } else if (json['photo'] != null) {
        imageUrl = json['photo'].toString();
      } else if (json['coverImage'] != null) {
        imageUrl = json['coverImage'].toString();
      }

      return EventModel(
        id: json['_id']?.toString(),
        title: json['title']?.toString() ?? json['name']?.toString(),
        description: json['description']?.toString(),
        category: json['category']?.toString(),
        status: json['status']?.toString(),
        hostCompany: json['hostCompany']?.toString(),
        isRecurring: json['isRecurring']?.toString(),
        date: parsedDate,
        time: json['time']?.toString(),
        price: json['price']?.toString(),
        type: json['type']?.toString(),
        paid: json['paid'] is bool
            ? json['paid']
            : json['paid']?.toString().toLowerCase() == 'true',
        host: json['host']?.toString(),
        attendees: attendees,
        location: location,
        v: json['__v'] is int
            ? json['__v']
            : int.tryParse(json['__v']?.toString() ?? ''),
        imageUrl: imageUrl, 
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'category': category,
        'status': status,
        'hostCompany': hostCompany,
        'isRecurring': isRecurring,
        'date': date?.toIso8601String(),
        'time': time,
        'price': price,
        'type': type,
        'paid': paid,
        'host': host,
        'attendees': attendees,
        'location': location?.toJson(),
        '__v': v,
        'imageUrl': imageUrl, 
      };
}

class LocationModel {
  final String? name;
  final String? address;
  final double? lat;
  final double? lng;

  LocationModel({
    this.name,
    this.address,
    this.lat,
    this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    try {
      return LocationModel(
        name: json['name']?.toString(),
        address: json['address']?.toString(),
        lat: json['lat'] is double
            ? json['lat']
            : json['lat'] is int
                ? json['lat'].toDouble()
                : double.tryParse(json['lat']?.toString() ?? ''),
        lng: json['lng'] is double
            ? json['lng']
            : json['lng'] is int
                ? json['lng'].toDouble()
                : double.tryParse(json['lng']?.toString() ?? ''),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'lat': lat,
        'lng': lng,
      };
}
