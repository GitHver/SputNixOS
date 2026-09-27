#! /usr/bin/env sh

nix() {

    # Only 'nix os' and 'nix hm' are in this function, else execute actual
    # nix command.
    case $1 in
        os)
            rebuild="nixos-rebuild"
        ;;
        hm)
            rebuild="home-manager"
        ;;
        *)
            command nix "$@"
            return $?
        ;;
    esac
    shift

    # remove the flags used in this script from $@ to pass it to the rebuild
    for arg; do
        shift
        case $arg in
            rollback)
                # rollback=true
                set -- "$@" "switch" "--rollback"
            ;;
            update)
                # update=true
                set -- "$@" "switch"
            ;;
            *)
                set -- "$@" "$arg" 
            ;;
        esac
    done

    $rebuild "$@"

}
