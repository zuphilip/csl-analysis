for $style in db:open("csl-styles")
for $etal in $style//(@et-al-min|@et-al-use-first)
(:et-al-use-first:)
order by -data($etal)
return <etal href="{ data($style//*:info/*:id) }">{ $etal }</etal>