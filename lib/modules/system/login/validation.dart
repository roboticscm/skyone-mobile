import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:skyone_mobile/util/locale_resource.dart';

class LoginValidation {
  final _usernameSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _loginSubject = BehaviorSubject<bool>();

  Stream<bool> get loginStream => _loginSubject.stream;

  Stream<String> get usernameStream =>
      _usernameSubject.stream.transform(StreamTransformer<String, String>.fromHandlers(handleData: (username, sink) {
        if ((username?.length ?? 0) < 1) {
          sink.add(LR.l10n('PORTAL.MSG.USERNAME_MUST_NOT_EMPTY'));
        } else {
          sink.add(null);
        }
      }));
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
        if ((password?.length ?? 0) < 1) {
          sink.add(LR.l10n('PORTAL.MSG.PASSWORD_MUST_NOT_EMPTY'));
        } else {
          sink.add(null);
        }
      }));
  Sink<String> get passwordSink => _passwordSubject.sink;

  LoginValidation() {
    Rx.combineLatest2(_usernameSubject, _passwordSubject, (String username, String password) {
      return (username?.length ?? 0) >= 1 && (password?.length ?? 0) >= 1;
    }).listen((bool enable) {
      _loginSubject.sink.add(enable);
    });
  }

  void dispose() {
    _usernameSubject.close();
    _passwordSubject.close();
    _loginSubject.close();
  }
}
