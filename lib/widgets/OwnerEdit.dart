import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodbasemedia/models/OwnerResponse.dart';
import 'package:moodbasemedia/services/Api.dart';
import 'dart:convert';

class OwnerEdit extends StatefulWidget {
  // final OwnerResponse owner;
  final OwnerData owner;
  final Function ownerCallback;
  OwnerEdit(this.owner, this.ownerCallback, {Key? key}) : super(key: key);

  @override
  _OwnerEditState createState() => _OwnerEditState();
}

class _OwnerEditState extends State<OwnerEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final ownerAddressController = TextEditingController();
  final ownerPhoneController = TextEditingController();
  bool isUpdateBtnClicked = false;
  ApiService apiService = ApiService('');
  String errorMessage = '';

  @override
  void initState() {
    ownerNameController.text = widget.owner.name;
    ownerAddressController.text = widget.owner.address;
    ownerPhoneController.text = widget.owner.phone;
    super.initState();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.owner.name = ownerNameController.text;
    widget.owner.address = ownerAddressController.text;
    widget.owner.phone = ownerPhoneController.text;

    await widget.ownerCallback(widget.owner);
    setState(() {
      isUpdateBtnClicked = false;
    });
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
                            setState(() {
                              isUpdateBtnClicked = true;
                            });
                            saveCategory();
                          },
                          child: Text('Save'))),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close')),
                  Text(errorMessage, style: TextStyle(color: Colors.red)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: () {
                      if (isUpdateBtnClicked) {
                        return const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        );
                      }
                    }(),
                  )
                ],
              ))),
    );
  }
}
