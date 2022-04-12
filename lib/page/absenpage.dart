import 'package:flutter/material.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("absen : 20")),
      body: Container(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      leading: FlutterLogo(),
                      title: Text('One-line with leading widget'),
                    ));
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
