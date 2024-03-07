_# deck_ng

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## run
* dart pub global activate -s git https://github.com/meltzow/screenshots.git
* export PATH="$PATH":"$HOME/.pub-cache/bin"
* screenshots --config=<screenshots.yaml>

* dart run build_runner watch --delete-conflicting-outputs

# development
* start the dockerservices in docker-compose.yml ("nextcloud" and "database")

## apis:
* https://github.com/nextcloud/deck/blob/master/docs/API.md
* https://github.com/nextcloud/deck/blob/master/docs/API-Nextcloud.md
* https://docs.nextcloud.com/server/latest/developer_manual/client_apis/LoginFlow/index.html
* https://docs.nextcloud.com/server/latest/developer_manual/digging_deeper/rest_apis.html

## others 
* https://m3.material.io/styles/icons/overview