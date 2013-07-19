#!/bin/bash

# Thick = 80
THICK=`echo -e -n "\xE2\xAE\x80"`
THIN=`echo -e -n "\xE2\x9D\xAF"`

COLOR='\[\033[0;36m\]'
HOSTCOLOR='\[\033[0;32m\]'
NORMAL='\[\033[0;37m\]'
START='\[\033[0;32m\]'

CLEAN=`echo -e -n "\xE2\x9C\x93"`
DIRTY=`echo -e -n "\xE2\x9C\xAD"`

pushd . > /dev/null

PROMPT=""

while true; do
   if [[ `pwd` == $HOME ]]; then
      PROMPT="~ $PROMPT"
      break
   fi

   if [[ `pwd` == '/' ]]; then
      PROMPT="/ $PROMPT"
      break
   fi

   PWD=`pwd`
   BASE=`basename "$PWD"`

   if [ -e '.git' ]; then
      STATUS="$CLEAN"
      if [[ `git status -s` != "" ]]; then
        STATUS="$DIRTY"
      fi

      PROMPT="$BASE $STATUS $PROMPT"
      break
   fi

   PROMPT="$THIN $BASE $PROMPT"
   cd ..
done

SSH=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
   SSH="$HOSTCOLOR$(whoami)@$HOSTNAME $THIN "
fi

echo -n "$SSH$COLOR$PROMPT$THIN$NORMAL "

popd > /dev/null
