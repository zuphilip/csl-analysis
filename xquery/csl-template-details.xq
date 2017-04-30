for $style in db:open("csl-styles")
for $link in $style//*:link[@rel='template']
return string-join(($style//*:info/*:id, $link/@href), ",")