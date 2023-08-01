library random_person_data;

import 'dart:convert';
import 'package:http/http.dart' as http;

class RandomPerson {
  Future<List<RandomPersonData>> get({
    int results = 1,
    Gender? gender,
    String? password,
    String? seed,
    Nationality? nationality,
    List<IncludeField>? includeFields,
    List<ExcludeField>? excludeFields,
  }) async {
    final Map<String, String?> parameters = {
      'results': results.toString(),
      'gender': gender.toString().split('.').last,
      'password': password,
      'seed': seed,
      'nat': nationality.toString().split('.').last,
      'inc': includeFields
          ?.map((field) => field.toString().split('.').last)
          .join(','),
      'exc': excludeFields
          ?.map((field) => field.toString().split('.').last)
          .join(','),
    };

    final Uri apiUrl = Uri.parse(baseUrl).replace(queryParameters: parameters);

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];

        return results
            .map((userJson) => RandomPersonData.fromJson(userJson))
            .toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

const String baseUrl = 'https://randomuser.me/api/1.4/';

enum Gender { male, female }

enum Nationality {
  AU,
  BR,
  CA,
  CH,
  DE,
  DK,
  ES,
  FI,
  FR,
  GB,
  IE,
  IN,
  IR,
  MX,
  NL,
  NO,
  NZ,
  RS,
  TR,
  UA,
  US,
}

enum IncludeField {
  gender,
  name,
  location,
  email,
  login,
  registered,
  dob,
  phone,
  cell,
  id,
  picture,
  nat
}

enum ExcludeField {
  gender,
  name,
  location,
  email,
  login,
  registered,
  dob,
  phone,
  cell,
  id,
  picture,
  nat
}

class Name {
  String? title;
  String? first;
  String? last;

  Name({this.title, this.first, this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class UserStreet {
  int? number;
  String? name;

  UserStreet({required this.number, required this.name});

  factory UserStreet.fromJson(Map<String, dynamic> json) {
    return UserStreet(
      number: json['number'],
      name: json['name'],
    );
  }
}

class UserCoordinates {
  String? latitude;
  String? longitude;

  UserCoordinates({required this.latitude, required this.longitude});

  factory UserCoordinates.fromJson(Map<String, dynamic> json) {
    return UserCoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class UserTimezone {
  String? offset;
  String? description;

  UserTimezone({required this.offset, required this.description});

  factory UserTimezone.fromJson(Map<String, dynamic> json) {
    return UserTimezone(
      offset: json['offset'],
      description: json['description'],
    );
  }
}

class Location {
  UserStreet? street;
  String? city;
  String? state;
  String? country;
  String? postcode;
  UserCoordinates? coordinates;
  UserTimezone? timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: UserStreet.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'].toString(),
      coordinates: UserCoordinates.fromJson(json['coordinates']),
      timezone: UserTimezone.fromJson(json['timezone']),
    );
  }
}

class Dob {
  String? date;
  int? age;

  Dob({this.date, this.age});

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

class UserLogin {
  String? uuid;
  String? username;
  String? password;
  String? salt;
  String? md5;
  String? sha1;
  String? sha256;

  UserLogin({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      uuid: json['uuid'],
      username: json['username'],
      password: json['password'],
      salt: json['salt'],
      md5: json['md5'],
      sha1: json['sha1'],
      sha256: json['sha256'],
    );
  }
}

class UserRegistered {
  String? date;
  int? age;

  UserRegistered({this.date, this.age});

  factory UserRegistered.fromJson(Map<String, dynamic> json) {
    return UserRegistered(
      date: json['date'],
      age: json['age'],
    );
  }
}

class UserID {
  String? name;
  String? value;

  UserID({this.name, this.value});

  factory UserID.fromJson(Map<String, dynamic> json) {
    return UserID(
      name: json['name'],
      value: json['value'],
    );
  }
}

class UserNationality {
  String? name;
  Nationality? nationality;

  UserNationality({this.name, this.nationality});

  factory UserNationality.fromString(String nat) {
    return UserNationality(
      name: nat,
      nationality: Nationality.values.firstWhere(
        (e) => e.toString().split('.').last == nat,
      ),
    );
  }
}

class RandomPersonData {
  Gender? gender;
  Name? name;
  Location? location;
  String? email;
  UserLogin? login;
  Dob? dob;
  UserRegistered? registered;
  String? phone;
  String? cell;
  UserLogin? id;
  Picture? picture;
  UserNationality? nat;

  RandomPersonData({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  factory RandomPersonData.fromJson(Map<String, dynamic> json) {
    return RandomPersonData(
      gender: json['gender'] == 'male' ? Gender.male : Gender.female,
      name: json.containsKey('name') ? Name.fromJson(json['name']) : null,
      location: json.containsKey('location')
          ? Location.fromJson(json['location'])
          : null,
      email: json.containsKey('email') ? json['email'] : null,
      login:
          json.containsKey('login') ? UserLogin.fromJson(json['login']) : null,
      dob: json.containsKey('dob') ? Dob.fromJson(json['dob']) : null,
      registered: json.containsKey('registered')
          ? UserRegistered.fromJson(json['registered'])
          : null,
      phone: json.containsKey('phone') ? json['phone'] : null,
      cell: json.containsKey('cell') ? json['cell'] : null,
      id: json.containsKey('id') ? UserLogin.fromJson(json['id']) : null,
      picture: json.containsKey('picture')
          ? Picture.fromJson(json['picture'])
          : null,
      nat: json.containsKey('nat')
          ? UserNationality.fromString(json['nat'])
          : null,
    );
  }
}
