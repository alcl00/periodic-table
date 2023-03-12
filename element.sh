#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ ! $1 ]]
then
{
  echo -e "Please provide an element as an argument."
}
# Search by atomic number
elif [[ $1 =~ ^[0-9]*$ ]]
then
{
  ATOMIC_NUMBER=$1
  GET_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  
  if [[ -z $GET_ELEMENT_RESULT ]]
  then
  {
    echo -e "I could not find that element in the database."
  }
  else
  {
    # Fetch data from elements table
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

    # Fetch data from properties table
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # Get element type
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  }
  fi
}
# Search by symbol
elif [[ $1 =~ ^[A-Z]$ ]] || [[ $1 =~ ^[A-Z][a-z]$  ]]
then
{
  SYMBOL=$1
  
  GET_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol='$SYMBOL'") 

  if [[ -z $GET_ELEMENT_RESULT ]]
  then
  {
    echo -e "I could not find that element in the database."
  }
  else
  {
    # Fetch data from elements table
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL'")
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$SYMBOL'")
    
    # Fetch data from properties table
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # Get element type
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  }
  fi
}
# Search by name
elif [[ $1 =~ ^[A-Z][a-z]+$ ]]
then
{
  NAME=$1
  GET_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE name='$NAME'") 

  if [[ -z $GET_ELEMENT_RESULT ]]
  then
  {
    echo -e "I could not find that element in the database."
  }
  else
  {
    # Fetch data from elements table
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$NAME'")
    
    # Fetch data from properties table
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # Get element type
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  }
  fi
}
else
{
  echo -e "I could not find that element in the database."
}
fi
