import 'package:flutter/material.dart';
import 'package:m03/pertemuan3/dbhelper.dart';
import 'ShoppingList.dart';

class ShoppingListDialog {
  final DBhelper _dBhelper;
  ShoppingListDialog(this._dBhelper);

  final txtName = TextEditingController();
  final txtSum = TextEditingController();
  final txtHrg = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    if (!isNew) {
      txtName.text = list.name;
      txtSum.text = list.sum.toString();
      txtHrg.text = list.sum.toString();
    } else {
      txtName.text = "";
      txtSum.text = "";
      txtHrg.text = "";
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping list' : 'edit shopping list'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(hintText: 'Shopping List Name'),
            ),
            TextField(
              controller: txtSum,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'sum'),
            ),
            TextField(
              controller: txtHrg,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'jumlah'),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('Save Shopping List'),
                  onPressed: () {
                    list.name = txtName.text != "" ? txtName.text : "empty";
                    list.sum = txtSum.text != "" ? int.parse(txtSum.text) : 0;
                    list.hrg = txtHrg.text != "" ? int.parse(txtHrg.text) : 0;
                    Navigator.pop(context);
                    _dBhelper.insertShoppingList(list);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
