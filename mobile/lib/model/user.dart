class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.emailVerifiedAt, 
      this.providerName, 
      this.providerId, 
      this.role, });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    role = json['role'];
  }
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic providerName;
  dynamic providerId;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['provider_name'] = providerName;
    map['provider_id'] = providerId;
    map['role'] = role;
    return map;
  }

}