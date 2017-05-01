declare namespace functx = "http://www.functx.com";
declare function functx:if-empty
  ( $arg as item()? ,
    $value as item()* )  as item()* {

  if (string($arg) != '')
  then data($arg)
  else $value
 } ;

(:this isn't super fast, it takes here around 5s:)
for $style in db:open("csl-styles")
let $id := $style//*:id
let $label := $style//*:title
let $issn := functx:if-empty($style//*:issn, "-")
let $eissn := functx:if-empty($style//*:eissn, "-")
let $field := $style//*:category/@field
let $format := $style//*:category/@citation-format
let $class := functx:if-empty($style//@class, "-")
let $lang := functx:if-empty($style//@default-locale, "-")
let $dependents := 
  for $dependingStyles in db:open("csl-styles")
  where $dependingStyles//*:link[@rel="independent-parent"]/@href=$id
  return $dependingStyles
let $numberOfDependents :=
  if ($style//*:link[@rel="independent-parent"] ) then
    "-1"
  else (
    count($dependents)
  )

return string-join(( $id, $label, $issn, $eissn, $numberOfDependents, $class, $format, $lang, string-join(($field), "|")), ",")