for $style in db:open("csl-styles")
group by $href := $style//*:link[@rel="independent-parent"]/@href
order by -count($style)
return <link count="{ count($style) }" href="{ $href }"/>