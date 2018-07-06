#The switch construct 

$x = "d1234"

switch -wildcard ($x)
    {
    "*1*" {"Contains 1"}
        "*5*" {"Contains 5"}
       "d*" {"Starts with 'd'"}
        default {"No matches"}
    }