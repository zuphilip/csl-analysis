for $style in db:open("csl-styles")
group by $param := $style//*:style/@default-locale
order by -count($style)
return string-join(($param, count($style)), ",")