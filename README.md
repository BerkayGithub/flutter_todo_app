# flutter_todo_app

A new Flutter project where users can make a to do list.

## UUID

Simple, fast generation of RFC4122 and RFC9562 UUIDs.

pubspec.yaml

    uuid: ^4.5.1

Task.dart

    factory Task.create(String description, DateTime dateTime){
      return Task(id: Uuid().v1(), description: description, dateTimeOfTask: dateTime, isCompleted: false);
    }

## DateTimePicker

A flutter date time picker inspired by flutter-cupertino-date-picker, you can choose date / time / date&time in multiple languages

pubspec.yaml

    flutter_datetime_picker_plus: ^2.2.0

home_page.dart

      DatePicker.showTimePicker(context, showSecondsColumn: false, onConfirm: (time){
      final newTask = Task.create(value, time);
    });

## intl

Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

pubspec.yaml

    intl: ^0.20.2

task_list_item.dart

    DateFormat('hh:mm a').format(widget.task.dateTimeOfTask),

## Easy Localization

1.Easy translations for many languages
2.Load translations as JSON, CSV, Yaml, Xml using Easy Localization Loader
3.React and persist to locale changes
4.Supports plural, gender, nesting, RTL locales and more

In order to use easy localization first we need create json files for strings in assets folder.

pubspec.yaml

    easy_localization: ^3.0.8

      assets:
    - assets/translations/

main.dart

    runApp(
        EasyLocalization(
            supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
            path: 'assets/translations', // <-- change the path of the translation files
            fallbackLocale: Locale('en', 'US'),
            child: MyApp()
        ),
      );
      // Lines of code

    //Lines of code
    Widget build(BuildContext context) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

home_page.dart

    Text("remove_task").tr()
