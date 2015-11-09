#!/bin/bash
source $cmdpath/options.inc.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Autopush start"
    echo ""
fi

while read -r line; do

    # Trim line
    line=`echo $line | sed -e 's/^ *//g' -e 's/ *$//g'`

    # Skip if line is empty or a comment
    if [[ -z "$line" || $line == \#* ]]; then
        continue
    fi

    # Split the line
    splline=( $line )
    if [[ ${#splline[@]} -ne 4 ]]; then
        echo "config error: $line"
        continue
    fi
    project=${splline[0]}
    branch=${splline[1]}
    #remotes=${splline[2]} # only needed for merging
    private=${splline[3]} # only needed for pushing

    # Get to the project
    cd $project

    # Push to private
    if [[ ! $private == "-" ]]; then
        if [[ $verbose ]]; then
            echo ""
            echo -e "\e[1mproject: $project\e[0m"
            echo "> pushing to $private/$branch..."
            git push $private $branch > /dev/null
        else
            git push -q $private $branch
        fi
    fi

    croot
done < <(cat $helperpath/config/projects.conf)
if [[ $verbose ]]; then
    echo -e "\e[1mAutopush end\e[0m"
fi
