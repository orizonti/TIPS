#!/bin/bash
#FIND DIR TIPS (/STORAGE/TIPS) and batcat TIP_NAME_EXM.txt 
#GET_TIP TIP_NAME
#GET_TIP LIST
root_dir=$( dirname $(readlink /usr/bin/get-tip) ); echo "ROOT DIR: $root_dir" ;

EXAMPLE_NAME="LIST"
TAG_NAME="ALL"

if (( $# == 1 ))
then
EXAMPLE_NAME="${1^^}"
fi

if (( $# == 2 ))
then
EXAMPLE_NAME="${1^^}"
TAG_NAME="${2^^}"
fi

echo "GET TAGS: $TAG_NAME $EXAMPLE_NAME"
if [ $EXAMPLE_NAME == "LIST" ]; then echo "LIST"; fi
#================================================================
#LIST AVAILABLE EXAMPLES
examples_dir="" 
examples_files=""
if [ $EXAMPLE_NAME == "LIST" ]; then 

      #LIST OF ALL EXAMPLES DIR
      if [ $TAG_NAME != 'ALL' ]; then
      examples_dir=$(ls -R /home/$USER/TIPS | grep EXAMPLE | grep / | grep $TAG_NAME | sed 's/://');
      fi

      if [ $TAG_NAME == 'ALL' ]; then
      examples_dir=$(ls -R /home/$USER/TIPS | grep EXAMPLE | grep / | sed 's/://');
      fi

for dir in $examples_dir; do 
tag_name=$(echo $dir | sed "s/EXAMPLES//" | sed "s/EXAMPLE//" | sed "s/mnt\/d\/TIPS//" | sed "s/\/\///" | sed "s/\///");
#tag_name=$(echo $dir | sed 's/EXAMPLES//' | sed 's/EXAMPLE//' | sed "s/$root_dir//" );
echo "EXAMPLE TAG: $tag_name"
examples_files=$(ls -R $dir | grep txt | sed 's/_EXM//' | sed 's/.txt//');
echo $examples_files
echo "==================="
done
fi
echo "----------------------------------"

cd  $root_dir
find . -name "$EXAMPLE_NAME*" -type f | grep _EXM | xargs batcat -l bash

#====================================================
#FIND TIPS DIR
#echo $USER
#FLAG_TRY_FIND_TIPS=false;
#if [ ! -d "/home/$USER/TIPS" ]; then echo "~/TIPS DONT EXISTS"; FLAG_TRY_FIND_TIPS=true; fi
#
#tips_dir="/home/$USER/STORAGE/TIPS"
#if ($FLAG_TRY_FIND_TIPS) 
#then
#  tips_dir=$(fdfind -t d TIPS /);
#  ln -s $tips_dir /home/$USER/TIPS;
#  echo "CREATE LINK TO: $tips_dir"
#fi
#
#root_dir="/home/$USER/TIPS" ; ls -al $root_dir;
#====================================================
#
