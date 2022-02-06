import 'package:moodbasemedia/widgets/OwnerAdd.dart';
import 'package:moodbasemedia/widgets/OwnerEdit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:moodbasemedia/models/OwnerResponse.dart';
import 'package:moodbasemedia/providers/OwnerProvider.dart';

class Owners extends StatefulWidget {
  @override
  _OwnersState createState() => _OwnersState();
}

class _OwnersState extends State<Owners> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OwnerProvider>(context);

    OwnerResponse Owners = provider.owners;
    return Scaffold(
      appBar: AppBar(
        title: Text('Owners'),
      ),
      body: Container(
          // color: Theme.of(context).primaryColorDark,
          child: Center(
        child: () {
          if (Owners.data != null) {
            return ListView.builder(
                itemCount: Owners.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  OwnerData owner = Owners.data![index];
                  return ListTile(
                      title: Text(
                        owner.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return OwnerEdit(owner, provider.init);
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 24.0,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text('Do you want to delete?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () => deleteOwner(
                                                  provider.init,
                                                  owner,
                                                  context),
                                              child: Text('Delete')),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel')),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24.0,
                              ))
                        ],
                      ));
                });
          } else {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            );
          }
        }(),
      )),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return OwnerAdd(provider.init);
                });
          },
          child: Icon(Icons.add)),
    );
  }

  Future deleteOwner(Function callback, OwnerData owner, context) async {
    await callback(owner);
    Navigator.pop(context);
  }
}
