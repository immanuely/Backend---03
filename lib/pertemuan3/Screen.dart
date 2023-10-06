import 'package:flutter/material.dart';
import 'package:m03/pertemuan3/shopping_list_dialog.dart';
import 'package:m03/pertemuan3/dbhelper.dart';
import 'package:provider/provider.dart';
import 'MyProvider.dart';
import 'ShoppingList.dart';
import 'ItemScreen.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final DBhelper _dBhelper = DBhelper();
  int id = 0;
  @override
  Widget build(BuildContext context) {
    var tmp = Provider.of<ListProductProvider>(context, listen: true);
    _dBhelper.getmyShopingList().then((value) => tmp.setShoppingList = value);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
          )
        ],
      ),
      body: ListView.builder(
          itemCount:
              tmp.getShoppingList != null ? tmp.getShoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(tmp.getShoppingList[index].id.toString()),
              onDismissed: (direction) {
                String tmpName = tmp.getShoppingList[index].name;
                int tmpId = tmp.getShoppingList[index].id;
                setState(() {
                  tmp.deletedById(tmp.getShoppingList[index]);
                });
                _dBhelper.deleteShoppingList(tmpId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$tmpName deleted'),
                ));
              },
              child: ListTile(
                title: Text(tmp.getShoppingList[index].name),
                leading: CircleAvatar(
                  child: Column(
                    children: [
                      Text("${tmp.getShoppingList[index].sum}"),
                      Text("${tmp.getShoppingList[index].hrg}"),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ItemsScreen(tmp.getShoppingList[index]);
                  }));
                },
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ShoppingListDialog(_dBhelper).buildDialog(
                            context, tmp.getShoppingList[index], false);
                      },
                    );
                    _dBhelper
                        .getmyShopingList()
                        .then((value) => tmp.setShoppingList = value);
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return ShoppingListDialog(_dBhelper)
                    .buildDialog(context, ShoppingList(++id, "", 0, 0), true);
              });
          _dBhelper
              .getmyShopingList()
              .then((value) => tmp.setShoppingList = value);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _dBhelper.closeDB();
    super.dispose();
  }
}
