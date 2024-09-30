#!/bin/bash

##  CREATING-USER   ##

if [ $# -gt 0 ]; then
    user=$1
    echo $user
    EXISTING_USER=$( sudo cat /etc/passwd | grep -i -w $user | cut -d ":" -f1 )
    if [ $user = $EXISTING_USER ]; then
        echo "the user $user is already exist, please enter the valid username"
    else 
        sudo useradd -m $user --shell /bin/bash
        echo "$user user created "
    fi        
else
    echo "please enter the valid petameter"
fi


## single user creation  ##

#!/bin/bash

if [ $# -gt 0 ]; then
    user=$1
    echo "Username provided: $user"
    
    # Check if the user already exists
    EXISTING_USER=$(sudo cat /etc/passwd | grep -i -w $user | cut -d ":" -f1 )
    if [ "$user" = "$EXISTING_USER" ]; then
        echo "The user $user already exists, please enter a valid username."
    else 
        # Create the user
        sudo useradd -m "$user" --shell /bin/bash
        echo "$user user created."

        # Generate a random temporary password
        Spec=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
        PASSWORD="temp@${RANDOM}${Spec}"
        
        # Set the password for the new user
        echo "$user:$PASSWORD" | sudo chpasswd
        echo "The temporary password for the user $user is: ${PASSWORD}"

        # Force the user to change their password on first login
        sudo passwd -e "$user"  # Forces the user to change the password on first login
    fi        
else
    echo "Please enter a valid parameter."
fi


# multi user creating #

#!/bin/bash

if [ $# -gt 0 ]; then

    for user in $@; do 
        # Check if the user already exists
        EXISTING_USER=$(sudo cat /etc/passwd | grep -i -w $user | cut -d ":" -f1 )
        if [ "$user" = "$EXISTING_USER" ]; then
            echo "The user $user already exists, please enter a valid username."
        else 
            # Create the user
            sudo useradd -m "$user" --shell /bin/bash
            echo "$user user created."

            # Generate a random temporary password
            Spec=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
            PASSWORD="temp@${RANDOM}${Spec}"
        
            # Set the password for the new user
            echo "$user:$PASSWORD" | sudo chpasswd
            echo "The temporary password for the user $user is: ${PASSWORD}"

            # Force the user to change their password on first login
            sudo passwd -e "$user"  # Forces the user to change the password on first login
        fi
    done             
else
    echo "Please enter a valid parameter."
fi





# multi user creating using read commad  #


#!/bin/bash
read -p " enter usernames:" Muser
if [ -n "$Muser" ]; then
    for user in $Muser; do 
        # Check if the user already exists
        EXISTING_USER=$(sudo cat /etc/passwd | grep -i -w $user | cut -d ":" -f1 )
        if [ "$user" = "$EXISTING_USER" ]; then
            echo "The user $user already exists, please enter a valid username."
        else 
            # Create the user
            sudo useradd -m "$user" --shell /bin/bash
            echo "$user user created."

            # Generate a random temporary password
            Spec=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
            PASSWORD="temp@${RANDOM}${Spec}"
        
            # Set the password for the new user
            echo "$user:$PASSWORD" | sudo chpasswd
            echo "The temporary password for the user $user is: ${PASSWORD}"

            # Force the user to change their password on first login
            sudo passwd -e "$user"  # Forces the user to change the password on first login
        fi
    done             
else
    echo "Please enter a valid parameter."
fi

## restricting username to have only charectors ##


#!/bin/bash
read -p " enter usernames:" Muser
if [ -n "$Muser" ]; then
    for user in $Muser; do 
        # Check if the user already exists
        if [[ $USER =~ ^[a-zA-Z]+$ ]]; then
            EXISTING_USER=$(sudo cat /etc/passwd | grep -i -w $user | cut -d ":" -f1 )
            if [ "$user" = "$EXISTING_USER" ]; then
                echo "The user $user already exists, please enter a valid username."
            else 
                # Create the user
                sudo useradd -m "$user" --shell /bin/bash
                echo "$user user created."

                # Generate a random temporary password
                Spec=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
                PASSWORD="temp@${RANDOM}${Spec}"
        
                # Set the password for the new user
                echo "$user:$PASSWORD" | sudo chpasswd
                echo "The temporary password for the user $user is: ${PASSWORD}"

                # Force the user to change their password on first login
                sudo passwd -e "$user"  # Forces the user to change the password on first login
            fi
        else
            echo "username should have only char. please enter a valid username"    
    done             
else
    echo "Please enter username."
    echo "Exit..."
fi