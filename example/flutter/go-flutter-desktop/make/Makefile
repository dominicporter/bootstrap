# https://github.com/go-flutter-desktop/examples

include makefiles/common.mk

LIB_NAME=examples
LIB=github.com/go-flutter-desktop/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)


#SAMPLE=keyboard_event
#SAMPLE=mousebuttons
#SAMPLE=plugin_tutorial
#SAMPLE=pointer_demo
SAMPLE=stocks
#SAMPLE=xbox_controller
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE)


stocks-i18n-step1:

	# generate ui code --> i18n code ( intl_messages.arb from lib/stock_strings.dart )
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/stock_strings.dart
	ls -al cd $(LIB_FSPATH)/$(SAMPLE)/lib/i18n

stocks-i18n-step2:
	# generate arb string --> i18n code (a stock_messages_<locale>.dart for each stocks_<locale>.arb file and stock_messages_all.dart)
	cd $(LIB_FSPATH)/$(SAMPLE) && flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n \
   --generated-file-prefix=stock_ --no-use-deferred-loading lib/*.dart lib/i18n/stocks_*.arbs
    # Now you have all the "stock_messages_all, en, es.dart regenerated
	# Its used the stocks_en,es.arb as sources
	# Now each of the locale i18n dart code is populated with the translated string.
	
	



