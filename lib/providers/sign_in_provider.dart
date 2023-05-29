import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  // instance of firebaseauth, facebook, google and github
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  //hasError, errorCode, provider,uid, email, name, imageUrl
  bool _hasError = false;

  bool get hasError => _hasError;

  String? _errorCode;

  String? get errorCode => _errorCode;

  String? _provider;

  String? get provider => _provider;

  String? _uid;

  String? get uid => _uid;

  String? _name;

  String? get name => _name;

  String? _email;

  String? get email => _email;

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // sign in with google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // executing our authentication
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // signing to firebase user instance
        final User userDetails =
        (await firebaseAuth.signInWithCredential(credential)).user!;

        // now save all values
        _name = userDetails.displayName;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
            "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = "Sign in or Sign Up canceled.";
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  /*Future signInWithGitHub() async {
    try {
      // Perform the GitHub sign-in flow
      final FirebaseAuth auth = FirebaseAuth.instance;
      final OAuthProvider provider = OAuthProvider('github.com');
      final UserCredential userCredential =
      await auth.signInWithPopup(provider);

      // Get the user details
      final User? user = userCredential.user;

      if (user != null) {
        // Save the user details
        _name = user.displayName;
        _email = user.email;
        _imageUrl = user.photoURL;
        _provider = "GITHUB";
        _uid = user.uid;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          _errorCode =
          "You already have an account with us. Use correct provider";
          _hasError = true;
          break;
        case "null":
          _errorCode = "Some unexpected error occurred while trying to sign in";
          _hasError = true;
          break;
        default:
          _errorCode = e.toString();
          _hasError = true;
      }
      notifyListeners();
    } on PlatformException catch (e) {
      // Handle any platform-specific errors
      print('PlatformException during GitHub sign-in: ${e.message}');
      _errorCode = e.message;
      _hasError = true;
      notifyListeners();
    } catch (e) {
      // Handle other exceptions
      print('Exception during GitHub sign-in: $e');
      _errorCode = 'An unexpected error occurred';
      _hasError = true;
      notifyListeners();
    }
  }*/

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGitHub() async {
    try {
      final AuthCredential credential = GithubAuthProvider.credential(
        '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',
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User userDetails = userCredential.user!;

      // now save all values
      _name = userDetails.displayName;
      _email = userDetails.email;
      _imageUrl = userDetails.photoURL;
      _provider = "GITHUB";
      _uid = userDetails.uid;
      notifyListeners();
    } catch (e) {
      // Handle the GitHub login error
      print('GitHub login failed: $e');
    }
  }



  // sign in with facebook
  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    // getting the profile
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result
            .accessToken!.token}'));

    final profile = jsonDecode(graphResponse.body);

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        // saving the values
        _name = profile['name'];
        _email = profile['email'];
        _imageUrl = profile['picture']['data']['url'];
        _uid = profile['id'];
        _hasError = false;
        _provider = "FACEBOOK";
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
            "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // ENTRY FOR CLOUDFIRESTORE
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) =>
    {
      _uid = snapshot['uid'],
      _name = snapshot['name'],
      _email = snapshot['email'],
      _imageUrl = snapshot['image_url'],
      _provider = snapshot['provider'],
    });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
    FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "image_url": _imageUrl,
      "provider": _provider,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('image_url', _imageUrl!);
    await s.setString('provider', _provider!);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    notifyListeners();
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  // signout
  Future userSignOut() async {
    firebaseAuth.signOut;
    await googleSignIn.signOut();

    _isSignedIn = false;
    notifyListeners();
    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUser(User user, email, name) {
    _name = name;
    _email = email;
    _imageUrl =
    "https://winaero.com/blog/wp-content/uploads/2017/12/User-icon-256-blue.png";
    _uid = user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }
}
