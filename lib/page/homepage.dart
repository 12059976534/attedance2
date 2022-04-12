import 'dart:async';
import 'dart:convert';

import 'package:attendance2/auth/login.dart';
import 'package:attendance2/model/registrasi.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/getabsen.dart';
import '../service/absen.dart';
import '../service/getmasterlocation.dart';
import '../service/masterloation.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var absen = Absenservice();
  // var datalist = Getdataabsen();

  double currentlat = 0;
  double currentlong = 0;
  show() {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          // color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  _getcurent() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // return Future.error('Location permissions are denied');
      }
    }

    // Geolocator.getPositionStream().listen((event) {
    //   currentlat = event.latitude;
    //   currentlong = event.longitude;
    // });
    return Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            forceAndroidLocationManager: true)
        .then(
      (value) {
        currentlat = value.latitude;
        currentlong = value.longitude;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber, actions: [
        IconButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final status = await prefs.remove('login');
            final user = await prefs.remove('username');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return Login();
            })));
          },
          icon: Icon(Icons.logout_outlined),
        )
      ]),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      bool serviceEnabled;
                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('aktipkan gps'),
                        ));
                      } else {
                        show();
                        await _getcurent();
                        if (currentlat == 0 && currentlong == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ulagi data tidak tersimpan'),
                          ));
                        } else {
                          var send = await ServiceMaster(
                              "${currentlat},${currentlong}");

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('succces'),
                          ));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: ((context) {
                            return Homepage();
                          })));
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height / 7,
                      color: Colors.amber,
                      child: Center(
                        child: Text("create master location"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      bool serviceEnabled;
                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('aktipkan gps'),
                        ));
                      } else {
                        show();
                        await _getcurent();
                        if (currentlat == 0 && currentlat == 0) {
                          print(currentlat);
                          print(currentlong);
                        } else {
                          getMasterlocation().then((res) async {
                            var mlocation = res.data.location.toString();
                            var sp = mlocation.split(",");
                            double masterlt = double.parse(sp[0]);
                            double masterln = double.parse(sp[1]);

                            double distanceInMeters =
                                Geolocator.distanceBetween(masterlt, masterln,
                                    currentlat, currentlong);

                            if (distanceInMeters < 50) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final int? id = prefs.getInt('id');
                              var sending = absen.createabsen(id);
                              sending.then((value) {
                                if (value.message == "succes") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'berhasil anda berada di lokasi ${distanceInMeters}'),
                                  ));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Homepage();
                                  }));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('gagal'),
                                  ));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Homepage();
                                  }));
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'anda tidak di lokasi absen gagal${distanceInMeters}'),
                              ));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Homepage();
                              }));
                            }
                            // print("meters: ${dista}");
                          });
                        }
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 7,
                      margin: EdgeInsets.all(5),
                      color: Colors.amber,
                      child: Center(
                        child: Text("absen"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: FutureBuilder<List<Datalist>>(
                future: absen.getabsen(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("data snapshot ${snapshot}");
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var s = snapshot.data;
                        return Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.black,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                color: Colors.white,
                              ),
                              Text(
                                "user_id: ${s![index].UserId}",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
