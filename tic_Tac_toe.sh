#!/bin/bash  
echo "Welcome To Tic-Tac-Toe Game"
declare -A  board
ROW=3
COLUMN=3
countOfmoves=0
totalNumberofMoves=$((ROW*COLUMN))

function resettingBoard()
{
    for (( i=0; i<$ROW; i++ ))
    do 
       for (( j=0; j<$COLUMN; j++ ))
       do
           board[$i,$j]=" "
       done
    done
}
resettingBoard

function Toss_And_Assigne_Symbol()
{
    Toss=$((RANDOM%2))
    case $Toss in
       1)
          player=x ;;
       0)
          player=o ;;
     esac
     echo $player

}
Toss_And_Assigne_Symbol

function displayBoard()
{
     for (( i=0; i<$ROW; i++ ))
     do
            echo "---+---+---+"
       for (( j=0; j<$COLUMN; j++ ))
       do
            printf " ${board[$i,$j]} |"
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
         player=o
     else 
         player=x
     fi
}

function checkEmpty()
{
      if [[ ${board[$2,$3]} == " " ]]
      then
          board[$2,$3]=$1
          displayBoard
          countOfmoves=$((countOfmoves+1))
          changePlayer $1
      else
          echo "this poistion is not empty"
      fi
}

function checkwin()
{
        
     for (( i=0; i<$ROW; i++ ))
     do
         if [[ ${board[$i,$((i-i))]} == $1 && ${board[$i,$((i+1-i))]} == $1 && ${board[$i,$((i+2-i))]} == $1 ]]     
         then
               echo "win"
         exit
         fi
         if [[ ${board[$((i-i)),$i]} == $1 && ${board[$((i+1-i)),$i]} == $1 && ${board[$((i+2-i)),$i]} == $1 ]]
         then
               echo "win"
         exit
         fi
    done
    if [[ ${board[0,0]} == $1 && ${board[1,1]} == $1 && ${board[2,2]} == $1 ]]
    then
              echo "win"
              exit
    fi
    if [[ ${board[0,2]} == $1 && ${board[1,1]} == $1 && ${board[2,0]} == $1 ]]       
    then
              echo "win"
              exit
    fi
}

while [ $countOfmoves -lt  $totalNumberofMoves ]
do
      if [[ $player == x ]]
      then
          read -p "enter the row poistion" rowPoistion
          read -p "enter the column poistion" columnPoistion
          checkEmpty $player $rowPoistion $columnPoistion
          checkwin $player

      else
          Poistion=$((RANDOM%9))
          rowPoistion=$((Poistion/3))
          columnPoistion=$((Poistion%3))
          checkEmpty $player $rowPoistion $columnPoistion  
          checkwin $player
      fi
done    
