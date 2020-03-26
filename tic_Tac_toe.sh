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
          gamePlayer=x ;;
       0)
          gamePlayer=o ;;
     esac
     echo $gamePlayer

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
     if [[ $gamePlayer == x ]]
     then 
         gamePlayer=o
     else 
         gamePlayer=x
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

function Check_I_Can_Win()
{
   for (( row=0; row<$ROW; row++ ))
   do
        for (( column=0; column<$COLUMN; column++ ))
        do
            if  [[ ${board[$row,$column]} == " " ]]
            then
                  board[$row,$column]=$1
                  checkwin $1
                  if [[ $win -eq 0 ]]
                  then
                       board[$row,$column]=" "
                  fi
           fi
       done
   done
}

function checkwin()
{
     win=0
     for (( i=0; i<$ROW; i++ ))
     do
         if [[ ${board[$i,$((i-i))]} == $1 && ${board[$i,$((i+1-i))]} == $1 && ${board[$i,$((i+2-i))]} == $1 ]]     
         then
                  win=1
         fi
         if [[ ${board[$((i-i)),$i]} == $1 && ${board[$((i+1-i)),$i]} == $1 && ${board[$((i+2-i)),$i]} == $1 ]]
         then
                  win=1
         fi
    done
    if [[ ${board[0,0]} == $1 && ${board[1,1]} == $1 && ${board[2,2]} == $1 ]]
    then
                  win=1
    fi
    if [[ ${board[0,2]} == $1 && ${board[1,1]} == $1 && ${board[2,0]} == $1 ]]       
    then
                  win=1
    fi
    if [ $win -eq 1 ]
    then
             echo "win $1"
    exit
    elif [ $countOfmoves -eq $totalNumberofMoves ]
    then
             echo "match is tied"
    exit
    fi
}

while [ $countOfmoves -lt  $totalNumberofMoves ]
do
      if [[ $gamePlayer == x ]]
      then
          read -p "enter the row poistion" rowPoistion
          read -p "enter the column poistion" columnPoistion
          checkEmpty $gamePlayer $rowPoistion $columnPoistion

      else
          Check_I_Can_Win
          Poistion=$((RANDOM%9))
          rowPoistion=$((Poistion/3))
          columnPoistion=$((Poistion%3))
          checkEmpty $gamePlayer $rowPoistion $columnPoistion 
      fi
done    
