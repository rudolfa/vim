#! /usr/bin/env bash
#

_swim_completitions()
{

if [ "${#COMP_WORDS[@]}" != "2" ];then
	return
fi

confignames=`ls ~/.vim-configs`

COMPREPLY=($(compgen -W "$confignames" "${COMP_WORDS[1]}"))


}

complete -F  _swim_completitions  swim

