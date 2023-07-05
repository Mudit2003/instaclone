// login exception
import 'package:flutter/foundation.dart';

@immutable
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exception

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InavalidEmailAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

@immutable
class UserNotLoggedInAuthException implements Exception {}

class UserNameNotPossibleAuthException implements Exception {}
