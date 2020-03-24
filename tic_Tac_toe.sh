#!/bin/bash  
echo "Welcome To Tic-Tac-Toe Game"
declare -A  board
ROW=3
COLUMN=3
countOfmoves=0
totalNumberofMoves=$((ROW*COLUMN))

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

function Toss_And_Assigne_Symbol()
{
    Toss=$((RANDOM%2))
    if [[ $Toss -eq 0 ]]
    then
         player=x
         playerTurn=1
    else
         player=0
         playerTurn=1
    fi
        echo $player

}
Toss_And_Assigne_Symbol

function displayBoard()
{
     for (( i=1; i<=$ROW; i++ ))
     do
            echo "---+---+---+"
       for (( j=1; j<=$COLUMN; j++ ))
       do
            echo -e " ${board[$i,$j]} |\c "
       done
            echo
     done
            echo "---+---+---+"     
}
displayBoard

function changePlayer()
{
     if [[ $player == x ]]
     then 
         player=0
         playerTurn=1
     else 
         player=x
         playerTurn=1
     fi
}

function checkEmpty()
{
      if [[ ${board[$2,$3]} == " " ]]
      then
          board[$2,$3]=$1
          displayBoard
          ((countOfmoves++))
          changePlayer $1
      else
          echo "this poistion is not empty"
      fi
}

while [ $countOfmoves -le  $totalNumberofMoves ]
do
      if [[ $player == x ]]
      then
          read -p "enter the row poistion" rowPoistion
          read -p "enter the column poistion" columnPoistion
          checkEmpty $player $rowPoistion $columnPoistion

      else
          read -p "enter the row poistion" rowPoistion
          read -p "enter the column poistion" columnPoistion
          checkEmpty $player $rowPoistion $columnPoistion  
      fi
done    
