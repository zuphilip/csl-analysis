for $style in db:open("csl-styles")
group by $href := ($style//*:link[@rel="template"]/@href)[1]
order by -count($style)
return <link count="{ count($style) }" href="{ $href }"/>