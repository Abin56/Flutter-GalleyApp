import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Directory? dir;

Future<bool> requestpermission() async {
  var store = Permission.storage;
  var access = Permission.accessMediaLocation;
  var secondaccess = Permission.manageExternalStorage;

  if (await store.isGranted &&
      await access.isGranted &&
      await secondaccess.isGranted) {
    return true;
  } else {
    var result = await store.request();
    var oneresult = await access.request();
    var tworesult = await secondaccess.request();

    if (result == PermissionStatus.granted &&
        oneresult == PermissionStatus.granted &&
        tworesult == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<Object> createpath() async {
  if (await requestpermission()) {
    dir = await getExternalStorageDirectory();
    String newpath = "";
    List<String> folders = dir!.path.split("/");

    for (var i = 1; i < folders.length; i++) {
      String folder = folders[i];

      if (folder != "Android") {
        newpath += "/" + folder;
      } else {
        break;
      }
    }
    newpath = newpath + "/Galleryfolder";
    dir = Directory(newpath);
    print(dir);
    if (!await dir!.exists()) {
      await dir!.create(recursive: true);
    }
    return newpath;
  } else {
    return false;
  }
}
