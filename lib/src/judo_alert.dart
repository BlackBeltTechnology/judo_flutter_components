part of judo.components;

Future<T?> judoAlert<T>({required BuildContext context, required String title, required String text}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}