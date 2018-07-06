#Break parctices

ForEach ($comp in $computers) {
  If (-not (Test-Ping $comp –quiet)) {
    Break
  }
}