
while getopts ":s" options "$2"; do
  case $options in
    s) # silent
      unset verbose
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
