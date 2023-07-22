// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get local {
    return Intl.message(
      'en',
      name: 'local',
      desc: '',
      args: [],
    );
  }

  /// `Theme:`
  String get themei {
    return Intl.message(
      'Theme:',
      name: 'themei',
      desc: '',
      args: [],
    );
  }

  /// `MEOW`
  String get meow_message {
    return Intl.message(
      'MEOW',
      name: 'meow_message',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `TAP`
  String get tap {
    return Intl.message(
      'TAP',
      name: 'tap',
      desc: '',
      args: [],
    );
  }

  /// `Todo_list`
  String get Todo_list {
    return Intl.message(
      'Todo_list',
      name: 'Todo_list',
      desc: '',
      args: [],
    );
  }

  /// `No data!`
  String get no_data {
    return Intl.message(
      'No data!',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `+smmth`
  String get smthnk {
    return Intl.message(
      '+smmth',
      name: 'smthnk',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Set Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Set Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Set Light Theme`
  String get lightTheme {
    return Intl.message(
      'Set Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkThemeSh {
    return Intl.message(
      'Dark',
      name: 'darkThemeSh',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightThemeSh {
    return Intl.message(
      'Light',
      name: 'lightThemeSh',
      desc: '',
      args: [],
    );
  }

  /// `Donat`
  String get donat {
    return Intl.message(
      'Donat',
      name: 'donat',
      desc: '',
      args: [],
    );
  }

  /// `Buy PRO (without ads)`
  String get pro {
    return Intl.message(
      'Buy PRO (without ads)',
      name: 'pro',
      desc: '',
      args: [],
    );
  }

  /// `John`
  String get name {
    return Intl.message(
      'John',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Choose Food-icon:`
  String get food {
    return Intl.message(
      'Choose Food-icon:',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Write your food:`
  String get food_str {
    return Intl.message(
      'Write your food:',
      name: 'food_str',
      desc: '',
      args: [],
    );
  }

  /// `What you're ate...`
  String get ate {
    return Intl.message(
      'What you\'re ate...',
      name: 'ate',
      desc: '',
      args: [],
    );
  }

  /// `Cost:`
  String get cost {
    return Intl.message(
      'Cost:',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get user {
    return Intl.message(
      'Users',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `UserName:`
  String get username {
    return Intl.message(
      'UserName:',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Tip: Swipe for delete`
  String get swipetip {
    return Intl.message(
      'Tip: Swipe for delete',
      name: 'swipetip',
      desc: '',
      args: [],
    );
  }

  /// `Tap for edit`
  String get taptip {
    return Intl.message(
      'Tap for edit',
      name: 'taptip',
      desc: '',
      args: [],
    );
  }

  /// `Tap to copy data, \nand them tap GreenButton`
  String get taptip2 {
    return Intl.message(
      'Tap to copy data, \nand them tap GreenButton',
      name: 'taptip2',
      desc: '',
      args: [],
    );
  }

  /// `Tap the RIGHT SIDE of food-button for choosing it :)`
  String get taptip3 {
    return Intl.message(
      'Tap the RIGHT SIDE of food-button for choosing it :)',
      name: 'taptip3',
      desc: '',
      args: [],
    );
  }

  /// `MANUAL: Choose which user-view you do. Tap to right-side of food, for choose it(green). Tap to left-side for editing it. Swipe for deleting.`
  String get usetip {
    return Intl.message(
      'MANUAL: Choose which user-view you do. Tap to right-side of food, for choose it(green). Tap to left-side for editing it. Swipe for deleting.',
      name: 'usetip',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Write your currency:`
  String get currency {
    return Intl.message(
      'Write your currency:',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Take a new Bill`
  String get bill {
    return Intl.message(
      'Take a new Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Bill-maker`
  String get bill2 {
    return Intl.message(
      'Bill-maker',
      name: 'bill2',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill3 {
    return Intl.message(
      'Bill',
      name: 'bill3',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get bill4 {
    return Intl.message(
      'Bills',
      name: 'bill4',
      desc: '',
      args: [],
    );
  }

  /// `Calculating is now easier!`
  String get discr {
    return Intl.message(
      'Calculating is now easier!',
      name: 'discr',
      desc: '',
      args: [],
    );
  }

  /// `DoubleTap to Bill for copying in your buffer.`
  String get buffer {
    return Intl.message(
      'DoubleTap to Bill for copying in your buffer.',
      name: 'buffer',
      desc: '',
      args: [],
    );
  }

  /// `Write names, who ate:`
  String get useradd1 {
    return Intl.message(
      'Write names, who ate:',
      name: 'useradd1',
      desc: '',
      args: [],
    );
  }

  /// `(splitting by space)`
  String get useradd2 {
    return Intl.message(
      '(splitting by space)',
      name: 'useradd2',
      desc: '',
      args: [],
    );
  }

  /// `John VasyaK  MisterJohnson...`
  String get useradd3 {
    return Intl.message(
      'John VasyaK  MisterJohnson...',
      name: 'useradd3',
      desc: '',
      args: [],
    );
  }

  /// `100 125 254`
  String get costlist {
    return Intl.message(
      '100 125 254',
      name: 'costlist',
      desc: '',
      args: [],
    );
  }

  /// `Pizza1 Pizza2 Potato`
  String get foodlist {
    return Intl.message(
      'Pizza1 Pizza2 Potato',
      name: 'foodlist',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `No one ate. \nFix that!`
  String get error1 {
    return Intl.message(
      'No one ate. \nFix that!',
      name: 'error1',
      desc: '',
      args: [],
    );
  }

  /// `No food. \nFix that!`
  String get error2 {
    return Intl.message(
      'No food. \nFix that!',
      name: 'error2',
      desc: '',
      args: [],
    );
  }

  /// `Number of food members are not the same as cost members. Fix That!`
  String get error3 {
    return Intl.message(
      'Number of food members are not the same as cost members. Fix That!',
      name: 'error3',
      desc: '',
      args: [],
    );
  }

  /// `File removed`
  String get file_removed {
    return Intl.message(
      'File removed',
      name: 'file_removed',
      desc: '',
      args: [],
    );
  }

  /// `Data copied. \nYou can press the green button`
  String get data_copied {
    return Intl.message(
      'Data copied. \nYou can press the green button',
      name: 'data_copied',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Image are from fluticons. \nAuthors: enamo-studios, nikita-golubev, icongeek26, good-ware, freepik, kiranshastry, voysla, aranagraphics, vector-stall, owldsgnr`
  String get icons {
    return Intl.message(
      'Image are from fluticons. \nAuthors: enamo-studios, nikita-golubev, icongeek26, good-ware, freepik, kiranshastry, voysla, aranagraphics, vector-stall, owldsgnr',
      name: 'icons',
      desc: '',
      args: [],
    );
  }

  /// `whopaids are executed by applying them to a data structure. Annotations in the whopaid refer to elements of the data structure .`
  String get template {
    return Intl.message(
      'whopaids are executed by applying them to a data structure. Annotations in the whopaid refer to elements of the data structure .',
      name: 'template',
      desc: '',
      args: [],
    );
  }

  /// `General bill:`
  String get bmaker1_bill {
    return Intl.message(
      'General bill:',
      name: 'bmaker1_bill',
      desc: '',
      args: [],
    );
  }

  /// `Food eaten by:\n`
  String get bmaker2_foodtitle {
    return Intl.message(
      'Food eaten by:\n',
      name: 'bmaker2_foodtitle',
      desc: '',
      args: [],
    );
  }

  /// `Dishes:\n`
  String get bmaker3_dishestitle {
    return Intl.message(
      'Dishes:\n',
      name: 'bmaker3_dishestitle',
      desc: '',
      args: [],
    );
  }

  /// `Maybe you missed:\n`
  String get bmaker4_missed {
    return Intl.message(
      'Maybe you missed:\n',
      name: 'bmaker4_missed',
      desc: '',
      args: [],
    );
  }

  /// `nobody ate it.\n`
  String get bmaker5_foodmissed {
    return Intl.message(
      'nobody ate it.\n',
      name: 'bmaker5_foodmissed',
      desc: '',
      args: [],
    );
  }

  /// `didn't eat at all.\n`
  String get bmaker6_guymissed {
    return Intl.message(
      'didn\'t eat at all.\n',
      name: 'bmaker6_guymissed',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'ua'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
