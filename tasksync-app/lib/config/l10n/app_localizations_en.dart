// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TaskSync';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get fullname => 'Full Name';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Register';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login';

  @override
  String get logout => 'Logout';

  @override
  String get tasks => 'Tasks';

  @override
  String get noTasksYet => 'No tasks yet!';

  @override
  String get createFirstTask => 'Tap + to create your first task.';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get dueDate => 'Due Date';

  @override
  String get createTask => 'Create Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Retry';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Please enter a valid email';
}
