//import 'dart:ffi';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:moodbasemedia/activities/Owners.dart';
import 'package:moodbasemedia/activities/TestPage.dart';
import 'package:flutter/material.dart';
import 'package:moodbasemedia/activities/upload.dart';
import 'package:moodbasemedia/models/TrackReponse.dart';
import 'package:moodbasemedia/providers/PlayListProvider.dart';
import 'package:moodbasemedia/services/Api.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? _image;
  String Mood = "?";
  TrackResponse trackss = TrackResponse();
  late ApiService apiService;
  late AudioPlayer player;
  bool showData = false;
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
  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  _uploadImageToServer(String title, File? file) async{
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://cc53-39-41-190-100.ngrok.io/predict"));
    //add text fields
    request.fields["text_field"] = "asds";
    //create multipart using filepath, string or bytes
    var pic = null;
    pic = await http.MultipartFile.fromPath("file1", file!.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    // var json = responseString
    var mood = json.decode(responseString);
    Mood = json.decode(responseString);
    print(Mood);
    _fetchTracks(Mood);
    setState(() {
      showData = true;
    });

  }

  _fetchTracks(String mood) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    this.apiService = ApiService(token);

    trackss = await apiService.fetchTracksByMood(mood);
    setState(() {
      trackss = trackss;
    });
  }

  @override
  Widget build(BuildContext context) {
    var showLoader = false;


      TrackResponse  tracks = trackss;
    setState(() {
      TrackResponse  tracks = trackss;
    });

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
                    children: <Widget>[
                      Text('Dashboard',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      Text('Mood ' + (Mood.isNotEmpty ? Mood.toString() : '' ),
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  )),
              Container(
                alignment: Alignment.center,
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(),
              ),
              Container(
                  alignment: Alignment.center,
                  child: _image == null
                      ? ElevatedButton(
                          onPressed: () {
                            _imgFromGallery();
                            setState(() {
                              showData = false;
                              Mood = '?';
                            });
                          },
                          child: const Text("Gallery Picture"))
                      : null),
              Container(
                  alignment: Alignment.center,
                  child: _image == null
                      ? ElevatedButton(
                      onPressed: () {
                        _imgFromCamera();
                        setState(() {
                          showData = false;
                          Mood = '?';
                        });
                      },
                      child: const Text("Take Picture"))
                      : null),
              Container(
                  alignment: Alignment.center,
                  child: _image != null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () => setState(() {
                            _image = null;
                            this.showData = true;
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

                            showData = true;

                            _uploadImageToServer('image', _image);
                            if (tracks.data != null) {
                            } else {}
                            _image = null;
                            setState(() {
                              showData = true;
                              _image = null;
                            });
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
              //Text("dsaf = " + showData.toString() + " === " + tracks.data.toString()),
              const Padding(padding: EdgeInsets.only(top: 50)),
              Container(
                  // color: Theme.of(context).primaryColorDark,
                  child: Center(
                child: () {
                  if (tracks.data != null && showData) {

                    return Expanded(
                        child: Container(
                            height: 350,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: tracks.data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  TrackData track = tracks.data![index];
                                  return ListTile(
                                      title: Text(
                                        track.title,
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
                                              )),
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
