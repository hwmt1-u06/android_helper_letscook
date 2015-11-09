#!/bin/bash
cd $PWD
helperpath="$(cd "$(dirname "${BASH_SOURCE[0]}")"&&pwd)"/helper # FIXME: this should get dynamic somehow
source $helperpath/func/output.sh
source $helperpath/config/settings.sh

if [ $use_archfix ]; then
    source $helperpath/inc/archfix.sh
fi

chmod 755 $helperpath/inc/cook.sh
source $helperpath/../build/envsetup.sh > /dev/null
alias cook=$helperpath/inc/cook.sh
echo ""
show_success "Environment prepared."
show_success "Type 'cook' to begin"
echo ""
