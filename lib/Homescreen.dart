import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttergallery/database/db.dart';
import 'package:fluttergallery/database/functions/functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  var box = Hive.box<GalleryModel>('Gallerys');
  File? image;
  dynamic imagesucess;
  dynamic imagepath;
  @override
  void initState() {
    createpath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GalleryModel> imagelist = box.values.toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
            onPressed: () {
              showbottomsheet(context);
              // box.clear();
            },
            icon: Icon(Icons.add_a_photo_outlined)),
      ),
      appBar: AppBar(
        title: Text('Gallery App'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Gallery',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 233, 226, 226),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: imagelist.isNotEmpty
                    ? ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder:
                            (BuildContext context, Box<GalleryModel> box, _) {
                          // Grid............................................
                          return GridView.builder(
                            itemCount: imagelist.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return RawMaterialButton(
                                onPressed: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(imagelist[index].image!)),
                                      )
                                      //adding some one
                                      ),
                                ),
                              );
                            },
                          );
                        })
                    : Center(
                        child: Text(
                        'NO VALUESSS',
                        style: TextStyle(color: Colors.black),
                      ))),
          )
        ],
      ),
    );
  }

  // BottomSheet
  Future<void> showbottomsheet(BuildContext ctx) async {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx1) {
        return Container(
          width: double.infinity,
          height: 150,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 35,
                        child: IconButton(
                            onPressed: () {
                              getgallery();
                            },
                            icon: const Icon(Icons.photo_library_outlined)),
                      ),
                    ),
                    CircleAvatar(
                      radius: 35,
                      child: IconButton(
                          onPressed: () {
                            getcamera();
                          },
                          icon: const Icon(Icons.camera_alt_outlined)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Gallery'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Camera'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // showbottom sheet ends...................................
  Future getcamera() async {
    var count = Random().nextInt(1000);

    final images = await ImagePicker().pickImage(source: ImageSource.camera);

    if (images == null) return;

    setState(() {
      imagepath = images.path;
    });
    Hive.box<GalleryModel>('Gallerys').add(GalleryModel(image: imagepath));

    var savepath = await createpath();

    File(imagepath).copy('${savepath}/00$count.jpg');
    count++;
  }

  // acess of gallery.............
  Future getgallery() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  //permission

}
