Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Random Person Data')),
      body: FutureBuilder<List<RandomPersonData>>(
        future: RandomPerson().get(results: 4, gender: Gender.female),
        builder: (BuildContext context,
            AsyncSnapshot<List<RandomPersonData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final randomUser = snapshot.data![index];
                return ListTile(
                  leading: Image.network(randomUser.picture!.large!),
                  title: Text(
                      '${randomUser.name!.first!} ${randomUser.name!.last!}'),
                );
              },
            );
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    ),
  );
}
