import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_zalo_login/flutter_zalo_login.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final locator = GetIt.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

final FacebookLogin facebookSignIn = FacebookLogin();

final zaloSignIn = ZaloLogin();