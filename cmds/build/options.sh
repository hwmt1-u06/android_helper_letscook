unset verbose

while getopts ":ckuv" options "$2"; do
  case $options in
    c) # pack recovery
      recovery=1
    ;;
    k) # pack kernel
      kernel=1
    ;;
    u) # kernel update
      kernel_update=1
    ;;
    v) # verbose
      verbose=1
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
