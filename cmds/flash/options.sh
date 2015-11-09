
while getopts ":as" options "$2"; do
  case $options in
    s) # silent
      unset verbose
    ;;
    a) # use adb instead of fastboot
      use_adb=1
    ;;
    \?)
      show_error "Invalid option: -$OPTARG" >&2
      show_usage
      exit 1
    ;;
    :)
      show_error "Option -$OPTARG requires an argument." >&2
      show_usage
      exit 1
    ;;
  esac
done
