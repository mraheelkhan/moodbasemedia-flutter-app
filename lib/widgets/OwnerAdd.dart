import 'package:moodbasemedia/models/OwnerResponse.dart';
import 'package:flutter/material.dart';

class OwnerAdd extends StatefulWidget {
  final Function ownerCallback;
  OwnerAdd(this.ownerCallback, {Key? key}) : super(key: key);

  @override
  _OwnerAddState createState() => _OwnerAddState();
}

class _OwnerAddState extends State<OwnerAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final ownerAddressController = TextEditingController();
  final ownerPhoneController = TextEditingController();

  String errorMessage = '';
  Future addOwner() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }
    OwnerData ownerData = OwnerData(
        name: ownerNameController.text,
        address: ownerAddressController.text,
        phone: ownerPhoneController.text);
    await widget.ownerCallback(ownerData);

    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) => setState(() {
                      errorMessage = '';
                    }),
                    controller: ownerNameController,
                    //initialValue:
                    //    category.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter owner Name';
                      }
                      if (value.length <= 3) {
                        return 'Owner name should be greater than 3 letters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner Name',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  TextFormField(
                    onChanged: (value) => setState(() {
                      errorMessage = '';
                    }),
                    controller: ownerAddressController,
                    //initialValue:
                    //    category.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter owner address';
                      }
                      if (value.length <= 5) {
                        return 'Owner address should be greater than 5 letters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner Address',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  TextFormField(
                    onChanged: (value) => setState(() {
                      errorMessage = '';
                    }),
                    controller: ownerPhoneController,
                    //initialValue:
                    //    category.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter owner phone';
                      }
                      if (value.length <= 7) {
                        return 'Owner phone number should be greater than 7 letters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner Phone',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            addOwner();
                          },
                          child: Text('Save'))),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close')),
                  Text(errorMessage, style: TextStyle(color: Colors.red))
                ],
              ))),
    );
  }
}
