#!/bin/bash
cd $PWD
helperpath="$(cd "$(dirname "${BASH_SOURCE[0]}")"&&pwd)"
source $helperpath/lib/output.sh

# Git config
git config --global color.ui 'auto'
git config --global push.default 'simple'
git config --global credential.helper 'cache --timeout=3600'

mkdir -p $helperpath/config
if [ ! -f $helperpath/config/settings.sh ]; then
    cp $helperpath/config_examples/settings.sh $helperpath/config/settings.sh
    show_success "example settings.sh created."
    fixed=1
fi

if [ ! -f $helperpath/config/projects.conf ]; then
    # get projects.conf for current rom type
    source $helperpath/inc/analyze.sh
    if [[ $rom_type == "cm" ]]; then
        cp $helperpath/config_examples/projects.conf.cm $helperpath/config/projects.conf
        show_success "example projects.conf created (cm)."
    elif [[ $rom_type == "carbon" ]]; then
        cp $helperpath/config_examples/projects.conf.carbon $helperpath/config/projects.conf
        show_success "example projects.conf created (carbon)."
    else
        cp $helperpath/config_examples/projects.conf.empty $helperpath/config/projects.conf
        show_warning "Unknown ROM-type. No default project.conf found. Please create your own one."
    fi
    fixed=1
fi

if [[ $fixed ]]; then
    show_warning "Review and edit the files in ./config/ !!!"
fi

chmod 755 $helperpath/config/settings.sh
chmod 755 $helperpath/config/projects.conf
chmod 755 $helperpath/*.sh
chmod 755 $helperpath/inc/*.sh
chmod 755 $helperpath/lib/*.sh
chmod 755 $helperpath/cmds/*.sh
chmod 755 $helperpath/cmds/*/*.sh
chmod 777 $helperpath/completion/*.sh
if [ ! -e letscook ]; then
    ln -s $helperpath/inc/prepare.sh letscook
    show_success "Symlink for letscook set."
fi

if [ ! -e /etc/bash_completion.d/letscook.sh ]; then
    sudo ln -s $helperpath/completion/letscook.sh /etc/bash_completion.d/letscook.sh
    show_success "Bash auto_completion script for 'cook' installed."
fi

echo ""
show_success "Setup done."
show_success "just type '. letscook' any time you come back here."
echo ""

exit 0
