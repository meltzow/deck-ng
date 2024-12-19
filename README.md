# Nextcloud Deck NG
Nextcloud Deck NG – Your Project Management Tool in your Nextcloud

# development
* start the dockerservices in docker-compose.yml ("nextcloud" and "database")
* cp example.env .env
* comment out all lines with "static final String" in lib/env/env.dart
* flutter_scripts run => "generate_files"

## running integration test (disabled currently)
* flutter run integration_test/main_test.dart --host-vmservice-port 9753 --disable-service-auth-codes --dart-define CONVENIENT_TEST_MANAGER_HOST=10.0.2.2 --dart-define CONVENIENT_TEST_APP_CODE_DIR=$PWD

## apis:
* https://github.com/nextcloud/deck/blob/master/docs/API.md
* https://github.com/nextcloud/deck/blob/master/docs/API-Nextcloud.md
* https://docs.nextcloud.com/server/latest/developer_manual/client_apis/LoginFlow/index.html
* https://docs.nextcloud.com/server/latest/developer_manual/digging_deeper/rest_apis.html

## others 
* https://m3.material.io/styles/icons/overview
* https://fonts.google.com/icons
* https://wiredash.com/
* https://flutterviz.io/

### automatic screenshots
* dart pub global activate flutter_scripts
* dart pub global activate -s git https://github.com/meltzow/screenshots.git
* export PATH="$PATH":"$HOME/.pub-cache/bin"
* flutter_scripts run

### stores & marketing URLs
* https://play.google.com/store/apps/details?id=net.meltzow.deckng
* https://apps.apple.com/us/app/deck-ng/id6443334702
* https://play.google.com/console/u/0/developers/7989774826491590599/app/4976068423564949204/app-dashboard?timespan=thirtyDays
* https://appstoreconnect.apple.com/apps/6443334702/distribution

# Marketing
title: Nextcloud Deck NG
slogan: efficient teamwork for your nextcloud
description: Nextcloud Deck NG is the ultimate app to manage your projects and tasks – flexible, secure, and fully integrated with your Nextcloud server. Whether for personal use or team collaboration, Nextcloud Deck NG helps you stay organized and work more efficiently.
Compatibility: Requires Nextcloud Server version X.X or higher with the Deck app enabled.
call-to-action-links:  https://play.google.com/store/apps/details?id=net.meltzow.deckng, https://apps.apple.com/us/app/deck-ng/id6443334702
promotional text: Take control of your projects with Nextcloud Deck NG! Simplify tasks, collaborate in real-time and stay secure with self-hosted data. Download now for smarter management!
Features: 
 * Login with Username, Password, or QR-Code
 * Kanban Board View with Drag-and-Drop
 * Assign Users and Labels to Cards 
 * Set Due Dates for Tasks
 * Multiple Sorting Options for Boards
 * Support for Subpath Logins like https://next.cloud/subpath
 * Easy Feedback: Send bugs or feature requests
layout: https://github.com/PaulleDemon/awesome-landing-pages/tree/main/src/apps/AISales
