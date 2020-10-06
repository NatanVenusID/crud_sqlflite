import 'package:flutter/material.dart';
import 'package:sqlite_app/model/db_helper.dart';
import 'package:sqlite_app/model/model_mahasiswa.dart';

class FormMahasiswa extends StatefulWidget {
  final ModelMahasiswa modelMahasiswa;
  FormMahasiswa(this.modelMahasiswa);
  
  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _firstNameControler;
  TextEditingController _lastNameControler;
  TextEditingController _mobileNoControler;
  TextEditingController _emailIdControler;
  TextEditingController _fakultasControler;
  TextEditingController _progdiControler;
  @override
  void initState() {
    super.initState();
    _firstNameControler =
        new TextEditingController(text: widget.modelMahasiswa.firstname);
    _lastNameControler =
        new TextEditingController(text: widget.modelMahasiswa.lastname);
    _mobileNoControler =
        new TextEditingController(text: widget.modelMahasiswa.mobileno);
    _emailIdControler =
        new TextEditingController(text: widget.modelMahasiswa.emailid);
    _fakultasControler =
        new TextEditingController(text: widget.modelMahasiswa.fakultas);
    _progdiControler =
        new TextEditingController(text: widget.modelMahasiswa.progdi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _firstNameControler,
            decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _lastNameControler,
            decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _mobileNoControler,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: 'Number Phone',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _emailIdControler,
            keyboardType: TextInputType.emailAddress, 
            decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _fakultasControler,
            decoration: InputDecoration(
                labelText: 'Fakultas',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _progdiControler,
            decoration: InputDecoration(
                labelText: 'Progdi',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
              color: Colors.amber,
              child: (widget.modelMahasiswa.id != null)
                  ? Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                if (widget.modelMahasiswa.id != null) {
                  db
                      .updateMahasiswa(ModelMahasiswa.fromMap({
                    'id': widget.modelMahasiswa.id,
                    'firstname': _firstNameControler.text,
                    'lastname': _lastNameControler.text,
                    'mobileno': _mobileNoControler.text,
                    'emailid': _emailIdControler.text,
                    'fakultas': _fakultasControler.text,
                    'progdi': _progdiControler.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveMahasiswa(
                    ModelMahasiswa(
                        _firstNameControler.text,
                        _lastNameControler.text,
                        _mobileNoControler.text,
                        _emailIdControler.text,
                        _fakultasControler.text,
                        _progdiControler.text),
                  )
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              })
        ],
      ),
    );
  }
}
