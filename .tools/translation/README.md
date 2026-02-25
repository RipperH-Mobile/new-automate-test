# Translator CLI for UChat.

1. Run to build env generated file.

```bash
fvm dart run build_runner build --define=envied_generator:envied=path=env.local --delete-conflicting-outputs
```

2. Run to translate the messages.

```bash
fvm dart run bin/translate.dart
```