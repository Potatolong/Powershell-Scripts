#Practicing the For and ForEach loop

For ($i = 0; $i –lt $objects.Count; $i++) {
  Write $objects[$i]
}

ForEach ($thing in $objects) {
  Write $thing
}