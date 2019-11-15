# google sheet

An approach to i18n and i10l that is decoupled so that it can be used by any projects or architecture.


The system supports custom templates which is vital for i10l aspects and gives absolute flexibility for things such as:

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

## Status

The API and data format will change as we are extending it currently.

Used by winwisely / getcouragenow.org currently for web, desktop & mobile apps based on flutter and golang.


## Use Cases

It is used for the following use cases:

Making Test data for your apps or servers.
- As an asset in Flutter for Mock data.

Making I18n data for your GUI.
- Write Dart annotators and use sourgen to read the JSON and gen the dart code.

Making static content like markdown.
- For Hugo static sites.
- Parse the JSON and place the markdown directly into the i18n folders.

## Using

Its a single binary on your laptop.

1. Setup your gsheet based on the Test gsheet. ( Language codes: https://cloud.google.com/translate/docs/languages )

2. Open your google sheet: File -> Publish to the web -> "Sheet name" option and "csv" option

3. Then update the gsheet config in your repo with this CSV URL.

4. Then run the gsheet tool in terminal. This will give you the data as JSON with a JSON file per language.

## Roadmap

### Decouple from google

Its not hard coupled to google. It uses Google sheets ( and its inherent google translate ) at the moment only for convenience. Its designed to be able to use anything for display, storage and machine translation.

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


