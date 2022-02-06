import 'package:flutter/material.dart';
import 'package:moodbasemedia/models/TrackReponse.dart';
import 'package:moodbasemedia/providers/AuthProvider.dart';
import 'package:moodbasemedia/services/Api.dart';

class PlayListProvider extends ChangeNotifier {
  TrackResponse tracks = TrackResponse();
  late ApiService apiService;
  late AuthProvider authProvider;

  PlayListProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);
    // this line above is the main part
    // init();
  }

  Future init() async {
    tracks = await apiService.fetchTracks();
    notifyListeners();
  }

  // Future addOwner(OwnerData owner) async {
  //   try {
  //     OwnerCreateResponse addOwner = await apiService.addOwner(owner);
  //     owners.data?.add(addOwner.data!);

  //     notifyListeners();
  //   } catch (Exception) {
  //     print(Exception);
  //   }
  // }

  // Future updateOwner(OwnerData owner) async {
  //   try {
  //     OwnerData updatedOwner = await apiService.updateOwner(owner);
  //     int? index = owners.data!.indexOf(owner);

  //     owners.data![index] = updatedOwner;

  //     notifyListeners();
  //   } catch (Exception) {
  //     print(Exception);
  //   }
  // }

  // Future deleteOwner(OwnerData owner) async {
  //   try {
  //     await apiService.deleteOwner(owner.id!.toInt());
  //     owners.data!.remove(owner);

  //     notifyListeners();
  //   } catch (Exception) {
  //     print(Exception);
  //   }
  // }
}
