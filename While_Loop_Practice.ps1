#While Loop 

While ($true) {
  $choice = Read-Host "Enter a number"
  If ($choice –eq 0) { break }
}