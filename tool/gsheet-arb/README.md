# GSheet-arb

i18n tool for Golang and flutter

The gsheet tool is awesome but we need to have our JSON get converted to ARB which is the default Flutter format for i18n.

We also need to do reconcilliation between the ARB Dart code and the Gsheet data.

## Flow

Normally:

1. Use the bootstrap gsheet tool to pull the translations

2. Then run the ARB to JSON and visa versa tools

3. Then use the normal flutter i18 n tooling.

Opposite:

Sometimes you want to know what your code calls for translations and what is over in the google sheets.

There may be a key missing in the google sheets Or keys orphaned in the google sheets.

1. SO we can use the ABR --> JSON to gen all the JSON.

2. then run the gsheet tool to bring all the translated data down

3. Then wire a simple compare tool in golang to compare each side to see what is orphaned and on which side ( dart arb code or data side)


## ARBS to JSON ( and back again)

Arb IS the default format for Flutter.

SO we need a way to convert back and forth between ARB and JSON

https://github.com/bmw-tech/arb-converter-cli

It will be best to rewrite this in golang actually. Its only 100 lines of code in typescript.

https://github.com/empirefox/protoc-gen-dart-ext/tree/master/pkg/arb
- this looks like a much better approach
- also has currency, etc




