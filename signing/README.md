# signing

Get a basic flutter project signing on a mac.

The Stocks example in the Makefile is a good one i think.
Add code to that make file to try to get signing working.

## Dev CI

fastlane is pretty much the way for devs to share their mobile flutter apps.

## PROD CI

The keys are of course secret.
Put keys in a folder outside Git / IDE and add a path to the Make file so the make file uses those keys.


## App Stores

Add the URLS and notes for how to get the keys.

## Targets

- windows 10
	- their app store.
- Mac 
	- their app store
	- non appstore using their notary / gatekeeper
- android
	- their app store
- ios
	- their app store
