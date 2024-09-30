#!/bin/bash

# Declare variables using single quotes
greeting='Hello, World!'

# Declare variables using double quotes
current_time="$(date +%H:%M:%S)"
name='Alice'
personalized_greeting="Hello, $name! The current time is $current_time."

# Print the variables
echo $greeting
echo $personalized_greeting
