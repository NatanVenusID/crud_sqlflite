import 'package:flutter/material.dart';

class PageDetail extends StatelessWidget {
  String pertama, terakhir, email, phone, fakultas, progdi;
  PageDetail(
      {this.pertama,
      this.terakhir,
      this.email,
      this.phone,
      this.fakultas,
      this.progdi});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
      ),
      body: Container( padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'First Name    : $pertama',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Last Name     : $terakhir',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Number Phone  : $phone',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email Address : $email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Fakultas      : $fakultas',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Progdi        : $progdi',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
