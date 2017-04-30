for $style in db:open("csl-styles")
for $variable in distinct-values($style//*:text/@variable|$style//*:names/@variable|$style//*:date/@variable)
where not($style/info/link[@rel="independent-parent"])
group by $variable
order by -count($style)
return string-join(($variable, count($style)), ",")