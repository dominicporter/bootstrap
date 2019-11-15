# google sheet

An approach to i18n and i10l that is decoupled so that it can be used by app projects.

How many languages ? https://cloud.google.com/translate/docs/languages

The system supports custom templates which is vital for i10l aspects and gives absolute flexibiity for things such as:

Gender 

| Key        | Fr           | En           | 
|-------------|-------------|-------------- | 
|`templated.contact(Gender.male)`| M. {{last_name}} | Mr {{last_name}}
|`templated.contact(Gender.female)`| Mme {{last_name}} | Mrs {{last_name}}




Pluralisation

| Key        | Fr           | En           | 
|-------------|-------------|-------------- | 
|`plurals.man(Plural.zero)`| hommes | man
|`plurals.man(Plural.one)`| Mme {{last_name}} | Mrs {{last_name}}


## Using

If you want to make a GSHeet exposed as a CSV just web publish it that way in the google drive.

https://support.google.com/docs/answer/183965?co=GENIE.Platform%3DDesktop&hl=en


Open google sheet:
File -> Publish to the web -> "Sheet name" option and "csv" option

Then update your config in your repo with this CSV Publishes URL.

Then as a dev kick off an export. This will give you the data as JSON with a JSON file per language.

From here you can essentially do anything you want with it.

GUI Test Data
- Copy it as an asset into the flutter assets and use as a read only DB

I18n 
- Write Dart annotators and use sourgen to read the JSON and gen the dart code.

Web Site staic content like markdown.
- Parse the JSON for the content you want and pump it into your wen site as appropriate.



## Roadmap

### Decouple from google

Its not hard coupled to google. It uses Google sheets ( and its inherent googele translate ) at the moment only for convenience. Its designed to be able to use anything for display, storage and machine translation.

- Its important that there is a GUI like google sheets so the cognitive load is as low as pssible.
	- So make a self hosted equivalent. There are various ones out there and we only need a basic table structure
- Machine translation
	- The server can use the various third party ones out there. Easy to do.
	- Reactive. Google Sheets are reactive in that when you change the source text all the secondary languages up date in real tiem in front of you.
		- SO with our own Server we can do the same with a websocket / GRPC style approach.
- Export
	- This is easy because the data is on our own server.
- Versions
	- Google Sheets has versioning.
	- We can match that easily by using a Key Value store for our own implementation with a sequence counter, which is just like a git hash.
	- Users can then go forward or back in time to the version then want in the Sheet GUI but also from the CLI.
- HA
	- Google gives you High availability for free.
	- We can use a 3 node Master / Follower pattern using RAFT replication so that data is on 3 servers always.
		- If the Master falls over the other 2 hold an election to elect a new Master. No data is lost and there is no loss of data or reactivity for the users.
- CLI
	- Does not change except it calls out server instead of the google server.


### Human Override

Allow humans to override the Machine Translations.

- Just add an extra column for every language.
- the CSV to JSON tool then just checks if there is an override and uses the override.

### Providence

This allows you from the end produce application or web site where the translation came from.

- During export we record the row and col each bit of text comes from and put it into the JSON.
- Then at runtime that data (row and col ) is used to point the developer back to the original source. Its just the original URLS with the range added: "/edit#gid=0&range=E8" added for google sheets ( https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0&range=E8 )
- When running in production env, it ignores the Providence of course, using environment flags.

Then there is the Providence in terms of the Version of the Google Sheet used.

- When exporting also get the Google Sheet Version number.
- This can then be embedded into the Web or App when compiled.



### Watch Mode

In debug mode, allow the data to update live when changed in the Google Sheet.
- runs in untyped mode
- Gsheets has trigger support. We tap into that via a hook server that then updates each developers running local system.
- this is 100% stateless. Its just a tap that is either ON or Off.


## URLS

Example URLS for config:

GOOGLE_SHEET_ID = 16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw

GOOGLE_SHEET_URL = https://docs.google.com/spreadsheets/d/$(GOOGLE_SHEET_ID)
GOOGLE_SHEET_URL (computed) = https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0

GOOGLE_SHEET_CSV = https://docs.google.com/spreadsheets/d/e/2PACX-1vTrndYJtszNP2_VL2t_z7wa03v2R01yq3wfRi4-RgmJMzXIEMzAX4OybZT7eEiqcmkZLWcFJhwJqJzA/pub?output=csv


## Libs

Flutter: https://github.com/aloisdeniel/flutter_sheet_localization

https://github.com/bratan/flutter_translate
- uses https://github.com/bratan/flutter_device_locale
https://github.com/bratan/flutter_translate_gen

Golang Gsheets: https://github.com/Iwark/spreadsheet/blob/v2/service.go




## Ops - Cloud run

Set it up to deploy on git commit.
https://cloud.google.com/run/docs/continuous-deployment-with-cloud-build



## Ops

ToDO

proper logging
"go.uber.org/zap"
https://github.com/knative/serving/blob/master/pkg/reconciler/autoscaling/hpa/hpa.go
- uses knative.dev/pkg/logging
https://github.com/knative/pkg/tree/master/metrics
https://github.com/knative/pkg/tree/master/logging


propper logging, tracing and metrics
https://github.com/jaegertracing/jaeger/tree/master/examples/hotrod
- this looks strong
- Here is how to setup the entry point: https://github.com/jaegertracing/jaeger/blob/master/examples/hotrod/cmd/root.go#L77
