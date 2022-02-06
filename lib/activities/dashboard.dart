import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:moodbasemedia/activities/Owners.dart';
import 'package:moodbasemedia/activities/TestPage.dart';
import 'package:flutter/material.dart';
import 'package:moodbasemedia/activities/upload.dart';
import 'package:moodbasemedia/models/TrackReponse.dart';
import 'package:moodbasemedia/providers/PlayListProvider.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? _image;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// Get from gallery
  // _imgFromCamera() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image as File;
  //   });
  // }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayListProvider>(context);
    var showLoader = false;
    TrackResponse tracks = provider.tracks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: const <Widget>[
                      Text('Dashboard',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  )),
              Container(
                alignment: Alignment.center,
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(),
              ),
              Container(
                  alignment: Alignment.center,
                  child: _image == null
                      ? ElevatedButton(
                          onPressed: () => {_imgFromGallery()},
                          child: const Text("Upload Picture"))
                      : null),
              Container(
                  alignment: Alignment.center,
                  child: _image != null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () => setState(() {
                            _image = null;
                          }),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.delete),
                            ],
                          ),
                        )
                      : null),
              Container(
                  alignment: Alignment.center,
                  child: _image != null
                      ? ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            _image = null;
                            showLoader = true;
                            provider.init();

                            if (tracks.data != null) {
                            } else {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.upload_file),
                              Text("Detect Mood")
                            ],
                          ),
                        )
                      : null),

              const Padding(padding: EdgeInsets.only(top: 50)),
              Container(
                  // color: Theme.of(context).primaryColorDark,
                  child: Center(
                child: () {
                  if (tracks.data != null) {
                    return Expanded(
                        child: Container(
                            height: 400,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: tracks.data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  TrackData track = tracks.data![index];
                                  return ListTile(
                                      title: Text(
                                        track.title + ' ' + track.url,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await player.setUrl(track.url);
                                                player.play();
                                              },
                                              icon: const Icon(
                                                Icons.play_arrow_outlined,
                                                color: Colors.black,
                                                size: 24.0,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                player.pause();
                                              },
                                              icon: const Icon(
                                                Icons.stop_circle_outlined,
                                                color: Colors.black,
                                                size: 24.0,
                                              ))
                                        ],
                                      ));
                                })));
                  } else {
                    if (showLoader) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      );
                    }
                  }
                }(),
              ))
              // ElevatedButton(
              //   onPressed: () => {
              //     // Navigator.of(context).pushNamed('/testPage')
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Upload()),
              //     )
              //   },
              //   child: Text('Upload'),
              //   style: ElevatedButton.styleFrom(
              //       primary: Color(0xff3700b3),
              //       minimumSize: Size(double.infinity, 36)),
              // ),
            ]),
      ),
    );
  }
}
