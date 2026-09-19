part of 'l10n_cubit.dart';

class L10nState extends Equatable {
  final Locale locale;

  const L10nState(this.locale);

  const L10nState.initial() : this(const Locale('en'));

  L10nState copyWith({Locale? locale}) => L10nState(locale ?? this.locale);

  @override
  List<Object?> get props => [locale];

  List<Locale> get supportedLocale => [const Locale('en'), const Locale('bn')];
}
