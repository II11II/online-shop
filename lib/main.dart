import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'ui/page/entry_point/entry_point.dart';

void main() {
  runApp(EasyLocalization(
    child: EntryPoint(), supportedLocales: [Locale('en'), Locale('ko'),Locale('ru')],
    path: 'assets/translations',
    useOnlyLangCode: true,
    fallbackLocale: Locale('en'),
  ));
}
