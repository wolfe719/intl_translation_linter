# Intl Translation Linter

[![Pub Version](https://img.shields.io/pub/v/smarter_translate_lints)](https://pub.dev/packages/smarter_translate_lints)
[![Dart SDK](https://img.shields.io/badge/Dart%20SDK-%20%3E%3D3.0.0-blue)](https://dart.dev)

## Introduction

Intl Translation Linter is a custom linting plugin for Flutter that helps catch missing translation strings in your code. It ensures that all strings are localized using the intl pub S variable, enhancing the accessibility and internationalization of your applications.

## Installation

To install Intl Translation Linter, add it as a dependency in your `pubspec.yaml` file:

```yaml
dev_dependencies:
  custom_lint: ^latest_version
  intl_translation_linter: ^1.0.3
```

Then, run `flutter pub get` to fetch the package.

## Configuration

To use Intl Translation Linter, you need to include it in your `analysis_options.yaml` file:

```yaml

analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - intl_translation_linter_use_s_role: true # for enabled or false for disabled
```

This will enable the linting rules provided by Intl Translation Linter in your Flutter project.

## Usage

Once installed and configured, Intl Translation Linter will automatically check your code for missing translation strings. If a string is not localized using the intl_translation pub's S variable, this linter will raise a warning.

Examples:

```dart
    const Text(
    'not translated text',
    ), // this example not using S will warn in the IDE

    // ignore: intl_translation_linter_use_s_role
    const Text(
    'Still not translated text',
    ), // this example not using S will NOTE warn in the IDE

    Text('translated text'
        .trim()), // this example not using S but also calling other string manipulations will warn in the IDE

    Text(S.of(context).translated_text
    ), // this example using S.of(context) will not warn in the IDE

    Text(S.current.translated_text
    ), // this example using S.current will not warn in the IDE
```

## Conclusion

Intl Translation Linter is a great tool for maintaining high-quality, accessible code in multilingual Flutter applications. By catching and warning about missing translations, it helps ensure that your app can reach a global audience.

## Attribution

Intl Translation Linter would not be possible without the work of SMART HOST TEKNOLOJİ (https://github.com/smarthost-tr) and their Smart Translate Lints repository!

I took their repository, and re-purposed it from the looking for "LocaleKeys" and {".i18n(", ".tr("}
to looking for "S.current" or "S.of("
