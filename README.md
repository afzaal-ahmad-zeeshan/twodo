# twodo

Todos for the two.

## Prepare

The app needs to prepare some resources before starting. Execute the following
script:

``` shell
npm install -g firebase-tools
firebase login
flutter pub get

dart pub global activate flutterfire_cli
flutterfire configure
```

Configure and connect the project to a Firebase project.
