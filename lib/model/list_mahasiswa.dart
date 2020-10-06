import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sqlite_app/model/db_helper.dart';
import 'package:sqlite_app/model/detailpage.dart';
import 'package:sqlite_app/model/form_mahasiswa.dart';
import 'package:sqlite_app/model/model_mahasiswa.dart';
import 'package:sqlite_app/ui/splash_screen.dart';


class ListMahasiswa extends StatefulWidget {

  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  List<ModelMahasiswa> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getAllMahasiswa().then((mahasiswas) {
      setState(() {
        mahasiswas.forEach((mahasiswa) {
          items.add(ModelMahasiswa.fromMap(mahasiswa));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('List Mahasiswa'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text("Sign Out"),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  size: 40,
                  color: Colors.amber,
                ),
                onPressed: () {
                  signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SplashScreen()));
                },
              ),
            ],
            
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.only(left: 16),
              title: Text(
                '${items[index].firstname} ${items[index].lastname}',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepOrangeAccent),
              ),
              subtitle: Text(
                '${items[index].emailid}',
              ),
              onTap: () {
                _navigateToMahasiswa(context, items[index]);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  AlertDialog hapus = AlertDialog(
                    backgroundColor: Colors.amber,
                    title: Text('Information'),
                    content: Container(
                      color: Colors.amber,
                      height: 100.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                              'Apakah anda yakin ingin hapus data ${items[index].firstname}')
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Yes!',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _deleteMahasiswa(context, items[index], index);
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'No!',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, child: hapus);
                },
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageDetail(
                              pertama: items[index].firstname,
                              terakhir: items[index].lastname,
                              phone: items[index].mobileno,
                              email: items[index].emailid,
                              fakultas: items[index].fakultas,
                              progdi: items[index].progdi)));
                },
                icon: Icon(Icons.visibility),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          onPressed: () {
            _createNewMahasiswa(context);
          }),
    );
  }

  _deleteMahasiswa(
      BuildContext context, ModelMahasiswa mahasiswa, int position) {
    db.deleteMahasiswa(mahasiswa.id).then((mahasiswas) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToMahasiswa(
      BuildContext context, ModelMahasiswa mahasiswa) async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormMahasiswa(mahasiswa)));
    if (result == 'update') {
      db.getAllMahasiswa().then((mahasiswas) {
        setState(() {
          items.clear();
          mahasiswas.forEach((mahasiswa) {
            items.add(ModelMahasiswa.fromMap(mahasiswa));
          });
        });
      });
    }
  }

  void _createNewMahasiswa(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FormMahasiswa(ModelMahasiswa('', '', '', '', '', ''))));
    if (result == 'save') {
      db.getAllMahasiswa().then((mahasiswas) {
        setState(() {
          items.clear();
          mahasiswas.forEach((mahasiswa) {
            items.add(ModelMahasiswa.fromMap(mahasiswa));
          });
        });
      });
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
