part of judo.components;

Future<T?> judoDialog<T>({required BuildContext context, required List<T> selectableList, required Function toStringFunction}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return SimpleDialog(
          children: selectableList.map<SimpleDialogOption>((element) => SimpleDialogOption(
            child: Text(toStringFunction(element)),
            onPressed: () => Navigator.pop(context, element),
          )).toList()
      );
    },
  );
}
