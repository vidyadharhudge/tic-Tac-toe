#!/bin/bash   
echo "Welcome To Tic-Tac-Toe Game"
declare -A board
ROW=3
COLUMN=3
countOfmoves=0
computerPlayer="o"
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
          gamePlayer=$computerPlayer ;;
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

function checkwin()
{
  win=0
  for (( i=0; i<$ROW; i++ ))
  do
         if [[ ${board[$i,$((i-i))]} == $1 && ${board[$i,$((i+1-i))]} == $1 && ${board[$i,$((i+2-i))]} == $1 ]]
         then
                  win=1

         elif [[ ${board[$((i-i)),$i]} == $1 && ${board[$((i+1-i)),$i]} == $1 && ${board[$((i+2-i)),$i]} == $1 ]]
         then
                  win=1


         elif [[ $i -eq 0 && ${board[$i,$i]} == $1 && ${board[$((i+1)),$((i+1))]} == $1 && ${board[$((i+1)),$((i+1))]} == $1 ]]
         then
                  win=1

         elif [[ ${board[0,2]} == $1 && ${board[1,1]} == $1 && ${board[2,0]} == $1 ]]
         then
                  win=1
         fi
         done

}

function changePlayer()
{
     if [[ $gamePlayer == x ]]
     then 
         gamePlayer=o
     else 
         gamePlayer=x
     fi
}


function Check_I_Can_Win()
{
   flag=1
   for (( row=0; row<$ROW; row++ ))
   do
        for (( column=0; column<$COLUMN; column++ ))
        do
            if  [[ ${board[$row,$column]} == " " ]]
            then
                       board[$row,$column]=$1
                       checkwin $1
                  if [ $win -eq 0 ]
                  then
                       board[$row,$column]=" "
                  elif [[ $win -eq 1 && ${board[$row,$column]} == $gamePlayer ]]
                  then
                       displayBoard
                       echo "$gamePlayer win"
                       exit
                 elif [ $win -eq 1 ]
                 then
                       board[$row,$column]=$gamePlayer
                       displayBoard
                       win=0
                       flag=0
                      ((countOfmoves++))
                       break  
                 fi
            fi
       done
       if [ $flag -eq 0 ]
       then
             break
       fi
       done
}

function checkEmpty()
{
      if [[ ${board[$2,$3]} == " " ]]
      then
             board[$2,$3]=$1
             displayBoard
             countOfmoves=$((countOfmoves+1))
             changePlayer $1
             checkwin $1
      else
             echo "the poistion is not empty"
      fi
}

function Check_For_Available_Corner()
{
    if [ $flag -eq 1 ]
    then
         for (( i=0; i<$ROW; $((i+2)) ))
         do
            for (( j=0; j<$COLUMN; $((j+2)) ))
            do
                  if [[ ${board[$i,$j]} == " " ]]
                  then
                     board[$i,$j]=$gamePlayer
                     displayBoard
                     flag=0
                     break
                  fi
           done
           if [ $flag -eq 0 ]
           then
                break
           fi
       done
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
          anotherPlayer="x"
          Check_I_Can_Win $gamePlayer
          Check_I_Can_Win $anotherPlayer
          Check_For_Available_Corner $gamePlayer
          if [ $flag -eq 1 ]
          then 
               Poistion=$((RANDOM%9))
               rowPoistion=$((Poistion/3))
               columnPoistion=$((Poistion%3))
               checkEmpty $gamePlayer $rowPoistion $columnPoistion 
         else
                  changePlayer $anotherPlayer
          fi
      fi
if [[ $win == 1 ]]
then
      break
fi
done
if [[ $win == 0 ]]
then
      echo "match is tie"
fi
