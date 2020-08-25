// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$id = $id();

class $id extends MessageLookupByLibrary {
  get localeName => 'id';
  
  final messages = {
		"app_name" : MessageLookupByLibrary.simpleMessage("Lancong"),
		"app_subjudul" : MessageLookupByLibrary.simpleMessage("lancong.id"),
		"profile_title" : MessageLookupByLibrary.simpleMessage("Profile"),
		"home_bar" : MessageLookupByLibrary.simpleMessage("Home"),
		"tourism" : MessageLookupByLibrary.simpleMessage("Torism"),
		"profile_bar" : MessageLookupByLibrary.simpleMessage("Profile"),
		"input_placeholder_employee" : MessageLookupByLibrary.simpleMessage("Username"),
		"input_placeholder_password" : MessageLookupByLibrary.simpleMessage("Password"),
		"label_enter" : MessageLookupByLibrary.simpleMessage("Login"),
		"label_out" : MessageLookupByLibrary.simpleMessage("Logout"),
		"no_connection" : MessageLookupByLibrary.simpleMessage("Please cek your connection for login. Thank you"),
		"aboutus" : MessageLookupByLibrary.simpleMessage("Tentang Kami"),
		"backup" : MessageLookupByLibrary.simpleMessage("Selamatkan data anda"),
		"pilih" : MessageLookupByLibrary.simpleMessage("Gambar anda dari mana?"),
		"picker" : MessageLookupByLibrary.simpleMessage("File Image"),
		"file" : MessageLookupByLibrary.simpleMessage("File"),
		"camera" : MessageLookupByLibrary.simpleMessage("Camera"),
		"delete" : MessageLookupByLibrary.simpleMessage("Delete confirmation"),
		"text_confirmation" : MessageLookupByLibrary.simpleMessage("Apakah anda akan menghapus"),
		"confirmation" : MessageLookupByLibrary.simpleMessage("Ya"),
		"rejected" : MessageLookupByLibrary.simpleMessage("Tidak"),
		"upload" : MessageLookupByLibrary.simpleMessage("Upload"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"id": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "id":
        return _$id;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
