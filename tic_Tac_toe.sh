#!/bin/bash -x 
echo "Welcome To Tic-Tac-Toe Game"
declare -A  board
ROW=3
COLUMN=3
function resettingBoard()
{
   for (( i=1; i<=$ROW; i++ ))
   do 
       for (( j=1; j<=$COLUMN; j++ ))
       do
           board[$i,$j]=" "
       done
   done
}
resettingBoard

function Toss()
{
   Toss=$((RANDOM%2))
   if [[ $Toss -eq 0 ]]
   then
         playerOne=x
   else
         playerTwo=0
   fi
}
Toss

