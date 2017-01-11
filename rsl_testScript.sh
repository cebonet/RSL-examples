function printsmltest() {
    tests=$(sml <$1|grep --color -E "\<t")
    tests_nobooleans=$(grep -v "true" <<< "$tests"|grep -v "false"|grep -v "val it")
    
    echo 'Passed tests: \n'
    GREP_COLOR='00;38;5;157' grep --color -E "\b(true)$"  <<< "$tests" # true assertions
    
    echo '\nFailed tests: \n'
    GREP_COLOR='1;31' egrep --color -E "\b(false)$" <<< "$tests" # false assertions
    
    echo '\nNon-assertion tests: \n'
    echo "$tests_nobooleans"
}

function rsltest() {
    filename=$1
    rsltc -m "$filename"
    smlfilename="${filename%.*}.sml"
    printsmltest "$smlfilename"
}
