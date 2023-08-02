# Random Person Data Library

The `random_person_data` library is a Dart package that provides a convenient way to fetch random user data from the Random User Generator API. It simplifies the process of making HTTP requests and parsing the received data into usable objects.

## Getting Started

To use this library, follow these steps:

1. Add the `random_person_data` package to your `pubspec.yaml` file:

```yaml
dependencies:
  random_person_data: ^1.0.1  # Replace with the latest version
```

2. Import the package in your Dart file:

```dart
import 'package:random_person_data/random_person_data.dart';
```

3. Start using the `RandomPerson` class to fetch random user data:

```dart
Future<void> fetchRandomPerson() async {
  final randomPerson = RandomPerson();
  try {
    List<RandomPersonData> persons = await randomPerson.get(results: 1);
    // Do something with the fetched data
    print(persons[0].name?.first); // Print the first name of the fetched person
  } catch (e) {
    print('Error fetching data: $e');
  }
}
```

## Results

The API will provide you with a formatted object containing random user data. The default format is JSON, but you can request different formats using the `format` parameter.

```json
{
  "results": [
    {
      "gender": "female",
      "name": {
        "title": "Miss",
        "first": "Jennie",
        "last": "Nichols"
      },
      "location": {
        "street": {
          "number": 8929,
          "name": "Valwood Pkwy"
        },
        "city": "Billings",
        "state": "Michigan",
        "country": "United States",
        "postcode": "63104",
        "coordinates": {
          "latitude": "-69.8246",
          "longitude": "134.8719"
        },
        "timezone": {
          "offset": "+9:30",
          "description": "Adelaide, Darwin"
        }
      },
      "email": "jennie.nichols@example.com",
      "login": {
        "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
        "username": "yellowpeacock117",
        "password": "addison",
        "salt": "sld1yGtd",
        "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
        "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
        "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d"
      },
      "dob": {
        "date": "1992-03-08T15:13:16.688Z",
        "age": 30
      },
      "registered": {
        "date": "2007-07-09T05:51:59.390Z",
        "age": 14
      },
      "phone": "(272) 790-0888",
      "cell": "(489) 330-2385",
      "id": {
        "name": "SSN",
        "value": "405-88-3636"
      },
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/75.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
      },
      "nat": "US"
    }
  ],
  "info": {
    "seed": "56d27f4a53bd5441",
    "results": 1,
    "page": 1,
    "version": "1.4"
  }
}
```

## API Errors

If the API service is offline or experiencing server issues, the response will be a simple JSON object with an error message.

```json
{
  "error": "Uh oh, something has gone wrong. Please tweet us @randomapi about the issue. Thank you."
}
```

## Requesting Multiple Users

You can fetch up to 5,000 generated users in one request using the `results` parameter.

```dart
RandomPerson randomPerson = RandomPerson();
List<RandomPersonData> persons = await randomPerson.get(results: 5000);
```

## Specifying a Gender

You can specify whether you want only male or only female users by adding the `gender` parameter to your request. Valid values for the `gender` parameter are "male" or "female," or you can leave it blank to receive both male and female users.

```dart
RandomPerson randomPerson = RandomPerson();
List<RandomPersonData> females = await randomPerson.get(gender: Gender.female);
List<RandomPersonData> males = await randomPerson.get(gender: Gender.male);
List<RandomPersonData> both = await randomPerson.get();
```

## Passwords

By default, passwords are chosen randomly from a list of ~10k top used passwords. Starting with version 1.1, you can have more control over how passwords are generated using the `password` option.

```dart
RandomPerson randomPerson = RandomPerson();
List<RandomPersonData> persons = await randomPerson.get(password: "upper,lower,1-16");
```

You can mix and match character sets for the `CHARSETS` option and specify the min/max length of the passwords you want to generate.

## Nationalities

You can request data for specific nationalities using the `nat` parameter. Pictures won't be affected, but data such as location, phone, etc., will be more appropriate for the specified nationality.

```dart
RandomPerson randomPerson = RandomPerson();
List<RandomPersonData> usPersons = await randomPerson.get(nationality: Nationality.US);
```

You can specify multiple nationalities using a comma-separated list.

## Including/Excluding Fields

You can specify which fields to include or exclude from the generated user data using the `inc` and `exc` parameters.

```dart
RandomPerson randomPerson = RandomPerson();
List<RandomPersonData> namesAndNats = await randomPerson.get(includeFields: [IncludeField.name, IncludeField.nat]);
List<RandomPersonData> withoutLogin = await randomPerson.get(excludeFields: [ExcludeField.login]);
```

## Using Previous Versions

If you want to access a specific version of the API that won't be affected by updates, you can specify the version in the API URL.

```dart
const String baseUrl = 'https://randomuser.me/api/1.4/';
```

## Disclaimer

This library relies on the Random User Generator API, and its availability and response formats are subject to change by the API provider. Please refer to the official Random User Generator documentation for the most up-to-date information.

For any issues or feedback related to this library, feel free to create an issue on GitHub. Happy

 coding!

---

**Note**: All project data in this library is based on the web API provided by https://randomuser.me/.