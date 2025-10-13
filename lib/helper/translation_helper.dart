import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class TranslationHelper{
  TranslationHelper._();

  static getDeviceLanguage(BuildContext context){
    var deviceLanguage = context.deviceLocale.countryCode?.toLowerCase();//Get device language and country code from that
    switch(deviceLanguage){
      case 'tr':
        return LocaleType.tr;
      case 'en':
        return LocaleType.en;
    }
  }
}