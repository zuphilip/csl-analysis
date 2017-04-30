for $style in db:open("csl-styles")
group by $format := $style//*:category/@citation-format
order by -count($style)
return string-join(($format, count($style)), ",")