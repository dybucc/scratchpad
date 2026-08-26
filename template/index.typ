#import "@local/scratchpad:0.1.4": *

#show: template.with(title: [#lorem(5)])

#title()

= #lorem(2) <test>
#lorem(500)

= #lorem(3)
@test mentions...

@lorem said...

#acite(<lorem>) said...

#pcite(<lorem>) said...

= #lorem(4)
#lorem(500)

#blist[#for i in array.range(10) [- #i]]

#bibliography("bib.yaml")
