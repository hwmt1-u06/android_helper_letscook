#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Automerge start"
    echo ""
fi

home=$PWD
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
    remotes=${splline[2]} # only needed for merging
    #private=${splline[3]} # only needed for pushing

    # Get to the project
    cd $home
    cd $project

    if [[ $verbose ]]; then
        echo ""
        echo -e "\e[1mproject: $project\e[0m"
    fi

    # Merge from each remote
    if [[ ! $remotes == "-" ]]; then
        remotes=`echo $remotes | tr ',' ' '`
        for remote in $remotes; do
            if [ `echo $remote | grep -o '.*/.*'` ]; then
                # Fetch source repo
                _remote=`echo $remote | grep -o '.*/' | grep -o '[a-zA-Z0-9.]*'`
                if [[ $verbose ]]; then
                    echo "> fetching "$remote"..."
                    git fetch $_remote
                    echo "> merging "$remote"..."
                    git merge $remote
                else
                    git fetch -q $_remote
                    git merge -q $remote
                fi
            else
                # Fetch source repo
                if [[ $verbose ]]; then
                    echo "> fetching "$remote"..."
                    git fetch $remote
                    echo "> merging "$remote/$branch"..."
                    git merge $remote/$branch
                else
                    git fetch -q $remote
                    git merge -q $remote/$branch
                fi
            fi
        done
    fi

done < <(cat $helperpath/config/projects.conf)
cd $home
if [[ $verbose ]]; then
    echo -e "\e[1mAutomerge end\e[0m"
fi
