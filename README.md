# 🐧 Linux Commands & Shell Scripting Guide

A comprehensive guide to essential Linux commands, text processing tools, and shell scripting concepts.


## Text Processing Commands

### awk Command

`awk` is a powerful text-processing command in Unix/Linux used to read and process text line by line.

#### Basic Syntax:
```bash
awk -F " " '{print $2}'
```

#### Explanation:

| Part         | Meaning                                                                                                                                         |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `awk`        | A powerful text-processing command in Unix/Linux used to read and process text line by line.                                                    |
| `-F " "`     | Sets the **field separator** (also called **delimiter**) to a **space character**. AWK will use spaces to split each line into multiple fields. |
| `{print $2}` | This is the **action block**. It tells AWK to print the **second field** from each line. `$2` refers to the **second field**.                   |

💡 **Default Behavior:**
If `-F " "` is not provided, AWK still splits by whitespace (space or tab), so `-F " "` is often optional when using space.

#### Examples:
```bash
# Print second field from each line
echo "apple banana cherry" | awk '{print $2}'
# Output: banana

# Use custom delimiter
echo "apple:banana:cherry" | awk -F ":" '{print $2}'
# Output: banana
```

---

### cut Command

`cut` is a Unix/Linux command-line utility to extract sections (fields or columns) from each line of input.

#### Basic Syntax:
```bash
echo "apple banana cherry" | cut -d " " -f 1
```

#### Summary:
- `cut` extracts parts of each line by splitting on a delimiter
- `-d` sets the delimiter (space `" "` here)
- `-f` specifies which field(s) to print
- Useful for quickly getting specific columns from structured text

#### Important Notes:
- If the delimiter is tab, you can omit `-d` because tab is the default delimiter for `cut`
- Unlike `awk`, `cut` only supports single-character delimiters
- For multi-character delimiters, use `awk` instead

#### Examples:
```bash
# Single-character delimiter
echo "apple:banana:cherry" | cut -d ":" -f 2
# Output: banana

# Multi-character delimiter (won't work with cut)
echo "apple::banana::cherry" | cut -d "::" -f 2
# Output: apple::banana::cherry (no splitting happens)

# Use awk for multi-character delimiters
echo "apple::banana::cherry" | awk -F "::" '{print $2}'
# Output: banana
```

---

### grep Command

`grep` is a Linux command-line utility used to search for patterns (text or regex) in files or input streams.

#### Basic Syntax:
```bash
grep [options] "pattern" filename
```

#### Common Options:

| Option | Description                                        |
| ------ | -------------------------------------------------- |
| `-i`   | Case-insensitive search                            |
| `-v`   | Invert match (show lines that **don't** match)     |
| `-n`   | Show line numbers for matches                      |
| `-c`   | Show count of matching lines                       |
| `-l`   | Show only the filenames with matches               |
| `-r`   | Recursive search through directories               |
| `-E`   | Use Extended Regular Expressions (same as `egrep`) |

#### Examples:
```bash
# Basic search
grep "error" logfile.txt

# Case-insensitive search
grep -i "ERROR" logfile.txt

# Show line numbers
grep -n "warning" logfile.txt

# Recursive search in directory
grep -r "TODO" /path/to/project/
```

---

## Shell Variables

### Exit Status ($?)

`$?` stores the exit status of the last executed command.

- **0** means success
- **Non-zero** (e.g., 1, 127) means an error occurred

#### Examples:
```bash
# Successful command
ls
echo $?  # Output: 0

# Failed command (command not found)
lp
echo $?  # Output: 127

# Using in scripts
if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```

#### Real Terminal Output:
```bash
kumar@LAPTOP-R0LFCE9D:~/shellscripting$ lp
Command 'lp' not found, but can be installed with:
sudo apt install cups-client  # version 2.4.1op1-1ubuntu4.11, or
sudo apt install lprng        # version 3.8.B-5
kumar@LAPTOP-R0LFCE9D:~/shellscripting$ echo $?
127
```

---

### Positional Parameters

| Variable | Description                                |
| -------- | ------------------------------------------ |
| `$0`     | Name of the script                         |
| `$1`     | First argument                             |
| `$2`     | Second argument                            |
| `$n`     | nth argument                               |

#### Example Script:
```bash
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
```

```bash
# Run the script
./myscript.sh apple banana

# Output:
# Script name: ./myscript.sh
# First argument: apple
# Second argument: banana
```

---

### Special Variables

#### `$@` and `$*`

```bash
#!/bin/bash

echo "Using \"\$@\":"
for arg in "$@"; do
  echo "$arg"
done

echo
echo "Using \"\$*\":"
for arg in "$*"; do
  echo "$arg"
done
```

```bash
./test.sh "apple pie" banana cherry

# Output:
# Using "$@":
# apple pie
# banana
# cherry
# 
# Using "$*":
# apple pie banana cherry
```

🧠 **Explanation:**
- ✅ `"$@"`: Treats each argument as its own word, even if it's quoted
- ✅ `"$*"`: Treats all arguments as one single string

#### `$#` - Number of Arguments

```bash
#!/bin/bash

echo "Total arguments: $#"
echo "Arguments: $@"

# Validate input
if [ $# -lt 2 ]; then
  echo "Usage: $0 <arg1> <arg2>"
  exit 1
fi
```

---

## Output Redirection

| Command | Meaning                                        |
| ------- | ---------------------------------------------- |
| `>`     | Redirect **stdout** (overwrite)                |
| `>>`    | Redirect **stdout** (append)                   |
| `2>`    | Redirect **stderr**                            |
| `2>&1`  | Redirect stderr to same place as stdout        |
| `&>`    | Bash-only: redirect **both** stdout and stderr |

#### Examples:

```bash
# Standard Output (stdout) Only
./script.sh > /tmp/store

# Standard Error (stderr) Only
./script.sh 2> /tmp/errors

# Both stdout and stderr to the Same File
./script.sh > /tmp/output 2>&1
# OR
./script.sh &> /tmp/output   # Bash-only shortcut

# stdout and stderr to Different Files
./script.sh > /tmp/stdout.log 2> /tmp/stderr.log

# Append Output Instead of Overwriting
./script.sh >> /tmp/store 2>&1
```

---

## Arithmetic Operations

### Using `expr`

#### Arithmetic Operators:

| Operator | Meaning        | Example       | Result |
| -------- | -------------- | ------------- | ------ |
| `+`      | Addition       | `expr 5 + 3`  | 8      |
| `-`      | Subtraction    | `expr 10 - 4` | 6      |
| `*`      | Multiplication | `expr 6 \* 2` | 12     |
| `/`      | Division       | `expr 8 / 2`  | 4      |
| `%`      | Modulus        | `expr 9 % 4`  | 1      |

#### Comparison Operators:

| Operator | Meaning          | Example                 | Result |
| -------- | ---------------- | ----------------------- | ------ |
| `=`      | Equal to         | `expr 5 = 5`            | 1      |
| `!=`     | Not equal to     | `expr 5 != 3`           | 1      |
| `>`      | Greater than     | `expr 5 \> 3`           | 1      |
| `<`      | Less than        | `expr 2 \< 3`           | 1      |
| `>=`     | Greater or equal | Not supported in `expr` |        |
| `<=`     | Less or equal    | Not supported in `expr` |        |

---

## Control Structures

### if Statement

```bash
num=10

if [ $num -gt 0 ]; then
  echo "Positive number"
elif [ $num -lt 0 ]; then
  echo "Negative number"
else
  echo "Zero"
fi
```

### for Loop

```bash
# Range-based loop
for i in {1..5}
do
   echo "Number $i"
done

# Array-based loop
for item in apple banana cherry
do
   echo "Fruit: $item"
done
```

### while Loop

```bash
count=1
while [ $count -le 5 ]
do
  echo "Count is $count"
  count=$((count + 1))
done
```

### Loop Control (break & continue)

#### `break` Statement
**Purpose:** Immediately exit (terminate) the current loop.

**Behavior:**
- Stops the loop entirely and continues executing the script after the loop
- If used in nested loops, `break` only exits the innermost loop (unless a numeric argument like `break 2` is used to exit multiple levels)

```bash
files=("file1.txt" "file2.txt" "file3.txt")
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "Found: $file"
        break  # Stop after finding the first existing file
    fi
done
```

#### `continue` Statement
**Purpose:** Skip the current iteration and jump to the next cycle of the loop.

**Behavior:**
- Ignores the rest of the code in the loop for the current iteration
- The loop continues with the next value (if any)

```bash
for num in {1..10}; do
    if (( num % 2 != 0 )); then
        continue  # Skip odd numbers
    fi
    echo "Even: $num"
done
```

#### Summary Table:

| Statement | Purpose                        | Syntax Tip                              |
| --------- | ------------------------------ | --------------------------------------- |
| `if`      | Conditional branching          | `[ condition ]`, ends with `fi`         |
| `for`     | Iterate over a list/range      | `for var in ...`, ends with `done`      |
| `while`   | Loop while a condition is true | `while [ condition ]`, ends with `done` |
| `break`   | Exit current loop              | Use inside loops to terminate early     |
| `continue`| Skip current iteration         | Use inside loops to skip to next cycle  |

---

## Regular Expressions

A regex is a pattern that describes a set of strings. It's used to match, search, replace, or validate text.

### Common Character Classes:

| Pattern    | Description                        |
| ---------- | ---------------------------------- |
| `[a-z]`    | Any lowercase letter               |
| `[A-Z]`    | Any uppercase letter               |
| `[0-9]`    | Any digit                          |
| `[a-zA-Z]` | Any letter                         |
| `.`        | Any character except newline       |
| `\s`       | Whitespace (space, tab, etc.)      |
| `\S`       | Non-whitespace                     |
| `\d`       | Digit (same as `[0-9]`)            |
| `\D`       | Non-digit                          |
| `\w`       | Word character (letter, digit, \_) |
| `\W`       | Non-word character                 |

### Example Script:

```bash
#!/bin/bash

read -p "Enter username: " USER

# Example 1: Only letters (a-z or A-Z)
if [[ $USER =~ ^[a-zA-Z]+$ ]]; then
    echo "✅ Only letters allowed: Valid username"
else
    echo "❌ Username contains non-letter characters"
fi

# Example 2: Letters + digits (alphanumeric)
if [[ $USER =~ ^[a-zA-Z0-9]+$ ]]; then
    echo "✅ Alphanumeric allowed: Valid username"
else
    echo "❌ Username is not alphanumeric"
fi

# Example 3: Alphanumeric with underscore (_) allowed
if [[ $USER =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "✅ Alphanumeric + underscores allowed: Valid username"
else
    echo "❌ Username has invalid characters (only a-z, A-Z, 0-9, _ allowed)"
fi

# Example 4: Minimum 6 characters
if [[ ${#USER} -ge 6 ]]; then
    echo "✅ Username length is at least 6"
else
    echo "❌ Username must be at least 6 characters long"
fi
```

---

## Arrays in Bash

### Basic Array Operations:

#### 1. Declaring an Array:
```bash
fruits=("apple" "banana" "cherry")
```

#### 2. Accessing Elements:
```bash
echo "${fruits[0]}"  # apple
echo "${fruits[1]}"  # banana
```

#### 3. All Elements:
```bash
echo "${fruits[@]}"  # apple banana cherry
```

#### 4. Length of Array:
```bash
echo "${#fruits[@]}"  # 3
```

#### 5. Looping Over an Array:
```bash
for fruit in "${fruits[@]}"; do
  echo "I like $fruit"
done
```

#### 6. Add Items to Array:
```bash
fruits+=("mango")
```

#### 7. Remove an Element:
```bash
unset 'fruits[1]'  # Removes banana
```

#### 8. Index-based Loop:
```bash
for i in "${!fruits[@]}"; do
  echo "Index $i: ${fruits[$i]}"
done
```

### Array Reference Table:

| Expression       | Meaning                      |
| ---------------- | ---------------------------- |
| `${array[0]}`    | First element                |
| `${array[@]}`    | All elements                 |
| `${!array[@]}`   | All indices                  |
| `${#array[@]}`   | Total number of elements     |
| `unset array[i]` | Deletes element at index `i` |

### Complete Array Example:

```bash
#!/bin/bash

colors=("red" "green" "blue")
colors+=("yellow")

echo "All colors: ${colors[@]}"
echo "Total: ${#colors[@]}"

for i in "${!colors[@]}"; do
    echo "Color $i = ${colors[$i]}"
done
```

---

## String Manipulation

### Variable Expansion:

- `${name}` expands to the value stored in the variable
- `${name[*]}` combines all elements into one string
- `${name[@]}` treats each element as a separate word (better for looping)
- `${!array[@]}` expands to the list of all indices in the array

### String Operations:

```bash
name='prasanna kumar'
echo ${name}           # displays the name
echo ${#name}          # displays the length (14)
echo ${name[@]:0:2}    # displays the first two letters (pr)
```

### String Slicing Syntax:

```bash
${name[@]:start:length}
```

| Part     | Meaning                                                                                    |
| -------- | ------------------------------------------------------------------------------------------ |
| `name`   | The variable (can be a string or array)                                                   |
| `[@]`    | Treats name as an array (but works on strings too)                                        |
| `start`  | The starting index (0-based) for extraction                                               |
| `length` | The number of characters (if name is a string) or elements (if array) to extract         |

### String Slicing Example:

```bash
name='prasanna kumar'

for i in {0..14}; do
    echo ${name[@]:0:$i}
done
```

**Output:**
```
(empty)
p
pr
pra
pras
prasa
prasan
prasann
prasanna
prasanna
prasanna k
prasanna ku
prasanna kum
prasanna kuma
prasanna kumar
```

### Best Practices:

- For arrays, explicitly use indices (`${name[0]}`, `${name[1]}`) or `[@]`/`[*]` for clarity
- For simple variables, `$name` or `${name}` works fine
- Use `"${array[@]}"` when looping over arrays to handle elements with spaces correctly

---

## 🎯 Key Takeaways

1. **Text Processing**: `awk`, `cut`, and `grep` are powerful tools for processing and filtering text
2. **Shell Variables**: Understanding `$?`, `$@`, `$*`, and `$#` is crucial for robust scripting
3. **Output Redirection**: Master redirection operators to control where your output goes
4. **Control Structures**: `if`, `for`, and `while` provide the logic flow for your scripts
5. **Loop Control**: `break` and `continue` give you fine-grained control over loop execution
6. **Regular Expressions**: Essential for pattern matching and text validation
7. **Arrays**: Powerful data structures for handling multiple values
8. **String Manipulation**: Bash provides rich string processing capabilities

This comprehensive guide covers the essential Linux commands and shell scripting concepts needed for effective system administration and automation! 🚀
