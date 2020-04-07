#!/bin/bash -x
echo "Welcome To Tic_Tac_Toe"
declare -A board
ROW=3
COLUMN=3
countOfmoves=0
computerPlayer="o"
totalNumberOfMoves=$((ROW*COLUMN))
#function for resetting the board
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
#function for toss and assign the symbol
function Toss_And_Assign_Symbol()
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
#function for display the game board
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
#function for check who is win
function checkwin()
{
   win=0
   for (( i=0; i<$ROW; i++ ))
   do
      if [[ ${board[$i,$((i-i))]} == $1 && ${board[$i,$((i+1-i))]} == $1 && ${board[$i,$((i+2-i))]} == $1 ]]
      then
         win=1
      elif [[ ${board[$((i-i)),$i]} == $1 && ${board[$((i+1-i)),$i]} == $1 &&  ${board[$((i+2-i)),$i]} == $1 ]]
      then
         win=1
      elif [[ $i -eq 0 && ${board[$i,$i]} == $1 && ${board[$((i+1)),$((i+1))]} == $1 && ${board[$((i+2)),$((i+2))]} == $1 ]]
      then
         win=1
      elif [[ ${board[0,2]} == $1 && ${board[1,1]} == $1 && ${board[2,0]} == $1 ]]
      then
         win=1
	   fi
	done
}
#function for changing the player 
function changePlayer() 
{
	if [[ $gamePlayer == x ]]
	then
		gamePlayer=o
	else
		gamePlayer=x
	fi
}
#function for check poistion is full or not
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
		echo "The Poistion is not empty"
	fi
}
#function for Avalibality of corner and center
function Check_For_Avalibale_Corner_And_Center()
{

	if [ $flag -eq 1 ]
	then
		for (( row=0; row<$ROW; row=$(( row+2 )) ))
		do
			for (( column=0; column<$COLUMN; column=$(( column+2 )) ))
			do
				if [[ ${board[$row,$column]} == " " ]]
				then
					board[$row,$column]=$gamePlayer
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
  if [ $flag -eq 1 ]
  then
		board[1,1]=$gamePlayer
		displayBoard
		flag=0
  fi
  if [ $flag -eq 1 ]
  then
	 for (( row=0;row<$ROW;row++ ))
	 do
		for (( column=0;column<$COLUMN;column++ ))
		do
			if [[ ${board[$row,$column]} == " " ]]
			then
				board[$row,$column]=$gamePlayer
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
#function for check i can win 
function Check_I_Can_Win()
{
	flag=1
   for (( r=0; r<$ROW; r++ ))
   do
      for (( c=0; c<$COLUMN; c++ ))
      do
         if [[ ${board[$r,$c]} == " " ]]
         then
               board[$r,$c]=$1
               checkwin $1
            if [ $win -eq 0 ]
            then
                board[$r,$c]=" "
             elif [[ $win -eq 1 && ${board[$r,$c]} == $gamePlayer ]]
             then
                displayBoard
                echo "$gamePlayer win !"
             exit
             elif [ $win -eq 1 ]
             then
                board[$r,$c]=$gamePlayer
                displayBoard
                win=0
                flag=0
                ((countOfmoves++))
                break
            fi
         fi
      done 
   done
}


resettingBoard
Toss_And_Assign_Symbol
displayBoard

while [ $countOfmoves -lt $totalNumberOfMoves ]
do
	if [[ $gamePlayer == x ]]
	then
		read -p "enter row position" rowPosition
		read -p "enter column position" columnPosition
		checkEmpty $gamePlayer $rowPosition $columnPosition
	else
		 AnotherPlayer="x"
		 Check_I_Can_Win $gamePlayer
		 heck_I_Can_Win $AnotherPlayer
		 Check_For_Avalibale_Corner_And_Center $gamePlayer
	    if [ $flag -eq 1 ]
	    then
		     position=$((RANDOM%9))
		     rowPosition=$((position/3))
		     columnPosition=$((position%3))
		     checkEmpty $gamePlayer $rowPosition $columnPosition
	    else
		     changePlayer $AnotherPlayer
	    fi
	fi
if [[ $win == 1 ]]
then
	break
fi
done
if [[ $win == 0 ]]
then
	echo "match tie"
fi
