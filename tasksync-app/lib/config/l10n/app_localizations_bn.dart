// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'টাস্কসিংক';

  @override
  String get login => 'লগইন';

  @override
  String get register => 'রেজিস্টার';

  @override
  String get email => 'ইমেইল';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get fullname => 'পুরো নাম';

  @override
  String get dontHaveAccount => 'অ্যাকাউন্ট নেই? রেজিস্টার করুন';

  @override
  String get alreadyHaveAccount => 'অ্যাকাউন্ট আছে? লগইন করুন';

  @override
  String get logout => 'লগআউট';

  @override
  String get tasks => 'টাস্কসমূহ';

  @override
  String get noTasksYet => 'এখনো কোনো টাস্ক নেই!';

  @override
  String get createFirstTask => '+ চেপে আপনার প্রথম টাস্ক তৈরি করুন।';

  @override
  String get title => 'শিরোনাম';

  @override
  String get description => 'বিবরণ';

  @override
  String get dueDate => 'শেষ সময়';

  @override
  String get createTask => 'টাস্ক তৈরি করুন';

  @override
  String get editTask => 'টাস্ক সম্পাদনা করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get fieldRequired => 'এই ঘরটি অবশ্যই পূরণ করতে হবে';

  @override
  String get invalidEmail => 'সঠিক ইমেইল ঠিকানা লিখুন';
}
