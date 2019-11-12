# google sheet

If oyu want to make a GSHeet exposed as a CSV just web publish it that way in the google drive.

https://support.google.com/docs/answer/183965?co=GENIE.Platform%3DDesktop&hl=en

As CSV:
Open google sheet
File -> Publish to the web -> "Sheet name" option and "csv" option





## Design

In debug mode, allow the data to update live when changed in the gsheet
- runs in untyped mode
- makes a call direct into gsheets via server
- providence, so has a little icon next to all translated text that open the gsheet at the right cell.
	- e.g: https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0&range=E8
	- Its just the original URLS with the range added: "/edit#gid=0&range=E8" added

In release mode, does not allow any live updating
- Compiled differently to gen different dart code.

## URLS

GOOGLE_SHEET_ID = 16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw
GOOGLE_SHEET_URL = https://docs.google.com/spreadsheets/d/$(GOOGLE_SHEET_ID)
GOOGLE_SHEET_CSV =https://docs.google.com/spreadsheets/d/e/2PACX-1vTrndYJtszNP2_VL2t_z7wa03v2R01yq3wfRi4-RgmJMzXIEMzAX4OybZT7eEiqcmkZLWcFJhwJqJzA/pub?output=csv

## Libs

Flutter: https://github.com/aloisdeniel/flutter_sheet_localization

https://github.com/bratan/flutter_translate
- uses https://github.com/bratan/flutter_device_locale
https://github.com/bratan/flutter_translate_gen



## Cloud run

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
