import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqlite_app/model/list_mahasiswa.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Google SignIn"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/venuslogo.png"))),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/signin.png"))),
                ),
                onTap: () {
                  _handleGoogleSign();
                },
              ),
              // RaisedButton(
              //   child: Text(
              //     "Logout Account",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   color: Colors.red,
              //   onPressed: () {
              //     signOut();
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSign() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;

    _alertDialog(user);
  }


  void _alertDialog(FirebaseUser user) {
    AlertDialog dialog = AlertDialog(
      content: Container(
        height: 230.0,
        child: Column(
          children: <Widget>[
            Text(
              "Sudah Login",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Divider(),
            ClipOval(
              child: Image.network(user.photoUrl),
            ),
            Text("anda login sebagai ${user.displayName}"),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  child: Text("OK!"),
                  onPressed: () {
                             Navigator.of(context).pushReplacement(MaterialPageRoute(
                 builder: (context) =>ListMahasiswa()));
                  },
                  color: Colors.green,  
                ))
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }
}
