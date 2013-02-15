#!/bin/bash

# Thick = 80
THICK=`echo -e -n "\xE2\xAE\x80"`
THIN=`echo -e -n "\xE2\xAE\x81"`

COLOR='\[\033[0;36m\]'
NORMAL='\[\033[0;37m\]'
START='\[\033[0;32m\]'

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
      PROMPT="$BASE $PROMPT"
      break
   fi

   PROMPT="$THIN $BASE $PROMPT"
   cd ..
done

echo -n "$COLOR$PROMPT$THIN$NORMAL "

popd > /dev/null
