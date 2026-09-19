import 'package:app/core/storage/prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'l10n_state.dart';

const localeKey = 'com.tasksync.app.locale';

@singleton
class L10nCubit extends Cubit<L10nState> {
  final SharedPrefsStorage _prefsStorage;

  L10nCubit(this._prefsStorage) : super(const L10nState.initial());

  void load() {
    final languageCode = _prefsStorage.getString(localeKey);

    emit(
      state.copyWith(locale: Locale(languageCode ?? state.locale.languageCode)),
    );
  }

  void switchLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
