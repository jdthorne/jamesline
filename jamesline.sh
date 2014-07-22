#!/bin/bash

# Thick = 80
THICK=`echo -e -n "\xE2\xAE\x80"`
THIN=`echo -e -n "\xE2\x9D\xAF"`

COLOR='\[\033[0;36m\]'
HOSTCOLOR='\[\033[0;32m\]'
MOUNTCOLOR='\[\033[0;33m\]'
NORMAL='\[\033[0;37m\]'
START='\[\033[0;32m\]'

CLEAN=`echo -e -n "\xE2\x9C\x93"`
DIRTY=`echo -e -n "\xE2\x9C\xAD"`

pushd . > /dev/null

PROMPT=""
MOUNT=""

MOUNTINFO="`df . | tail -n 1`"
MOUNTPOINT="`echo $MOUNTINFO | rev | cut -d ' ' -f 1 | rev`"
MOUNTISSSH="`echo $MOUNTINFO | grep '@'`"

if [[ "$MOUNTPOINT" != "/" ]]; then
  MOUNT="`echo $MOUNTINFO | cut -d ' ' -f 1 | sed 's^:/$^^'`"
  # MOUNT="`echo $MOUNTINFO | cut -d ' ' -f 1`"
fi

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

   if [ "$MOUNTISSSH" == "" ] && [ -e '.git' ]; then
      STATUS="$CLEAN"
      if [[ `git status -s` != "" ]]; then
        STATUS="$DIRTY"
      fi

      PROMPT="$BASE $STATUS $PROMPT"
      break
   fi

   if [[ "`pwd`" == "$MOUNTPOINT" ]]; then
      PROMPT="/ $PROMPT"
      break
   fi

   PROMPT="$THIN $BASE $PROMPT"
   cd ..
done

popd > /dev/null

SSH=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
   SSH="$HOSTCOLOR$(whoami)@$HOSTNAME $THIN "
fi

MOUNTP=""
if [[ "$MOUNT" != "" ]]; then
  MOUNTP="$MOUNTCOLOR$MOUNT $THIN "
fi

echo -n "$SSH$MOUNTP$COLOR$PROMPT$THIN$NORMAL "

