import 'package:flutter_test/flutter_test.dart';

import 'package:random_person_data/random_person_data.dart';

void main() {
  test('Fetch one random person', () async {
    final randomPerson = RandomPerson();
    final List<RandomPersonData> persons = await randomPerson.get();
    expect(persons.length, 1);
  });

  test('Fetch multiple random persons', () async {
    final randomPerson = RandomPerson();
    final List<RandomPersonData> persons = await randomPerson.get(results: 5);
    expect(persons.length, 5);
  });

  test('Fetch random persons with specific nationality', () async {
    final randomPerson = RandomPerson();
    final List<RandomPersonData> persons = await randomPerson.get(
      results: 5,
      nationality: Nationality.US,
    );

    // Check if all persons have the specified nationality
    expect(
      persons.every((person) => person.nat?.nationality == Nationality.US),
      true,
    );
  });

  test('Fetch random persons with specific included fields', () async {
    final randomPerson = RandomPerson();
    final List<RandomPersonData> persons = await randomPerson.get(
      results: 5,
      includeFields: [IncludeField.name, IncludeField.location],
    );

    // Check if all persons have the specified included fields
    expect(
      persons.every(
        (person) => person.name != null && person.location != null,
      ),
      true,
    );
  });

  test('Fetch random persons with specific excluded fields', () async {
    final randomPerson = RandomPerson();
    final List<RandomPersonData> persons = await randomPerson.get(
      results: 5,
      excludeFields: [ExcludeField.email, ExcludeField.cell],
    );

    // Check if none of the persons have the specified excluded fields
    expect(
      persons.every(
        (person) => person.email == null && person.cell == null,
      ),
      true,
    );
  });

  // Add more tests as needed to cover other functionalities of the RandomPerson class.
}
