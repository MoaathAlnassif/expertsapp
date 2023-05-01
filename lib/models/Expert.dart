class Expert {
  Expert({
    this.name,
    this.photo,
    this.skills,
    this.address,
    this.startTime,
    this.endTime,
    this.daysspace,
    this.phone,
    this.category,
    this.price,
    this.userId,
    this.id,
  });

  factory Expert.fromJson(dynamic json) {
    return Expert(
      name: json['name'],
      photo: json['photo'],
      skills: json['skills'],
      address: json['address'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      daysspace: json['Daysspace'],
      phone: json['phone'],
      category: json['category'],
      price: json['price'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  final name;
  final photo;
  final skills;
  final address;
  final startTime;
  final endTime;
  final daysspace;
  final phone;
  final category;
  final price;
  final userId;
  final id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['photo'] = photo;
    map['skills'] = skills;
    map['address'] = address;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['Daysspace'] = daysspace;
    map['phone'] = phone;
    map['category'] = category;
    map['price'] = price;
    map['user_id'] = userId;
    map['id'] = id;
    return map;
  }
}
