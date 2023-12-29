class color:
   PURPLE = '\033[1;35;48m'
   CYAN = '\033[1;36;48m'
   BOLD = '\033[1;37;48m'
   BLUE = '\033[1;34;48m'
   GREEN = '\033[1;32;48m'
   YELLOW = '\033[1;33;48m'
   RED = '\033[1;31;48m'
   END = '\033[1;37;0m'

import random
import time 

def add(a, b):
    return a + b
def subtract(a, b):
    return a - b
def multiply(a, b):
    return a * b
def divide(a, b):
    return a / b 

name = input(color.BLUE + 'Please enter your name: ' + color.END)
time.sleep(2)
print(color.YELLOW + f"Hello {name}! Welcome to 10 level of challenge! " + color.END)
time.sleep(2)

print(color.PURPLE + "Select operation:")
print("1.  Add  + ")
print("2.  Subtract  - ")
print("3.  Multiply  * ")
print("4.  Divide  / "  + color.END )

# while play:
for level in range(1, 11):
    choice = input(color.CYAN + "Enter choice ( 1 / 2 / 3 / 4 ): " + color.END)
    if choice in ('1', '2', '3', '4'):
        try:
            num1 = random.randint(1,100)
            num2 = random.randint(1,100)
            
        except ValueError:
            print("Invalid input. Please enter a number.")
            continue
        if choice == '1':
            answer = input(color.BOLD + f'What is {num1} + {num2} = ' + color.END)
            if int(answer) == num1 + num2:
                print(color.GREEN + f'Good job! You passed level number {level}' + color.END)
            else:
                print(color.RED + f'You are dumb you could not pass level {level}' + color.END)
                continue
        elif choice == '2':
            answer = input(color.BOLD + f'What is {num1} - {num2} = ' + color.END)
            if int(answer) == num1 - num2:
                print(color.GREEN + f'Good job! You passed level number {level}'+ color.END)
            else:
                print(color.RED + f'You are dumb you could not pass level {level}'+ color.END)
        elif choice == '3':
            answer = input(color.BOLD + f'What is {num1} * {num2} = ' + color.END)
            if int(answer) == num1 * num2:
                print(color.GREEN + f'Good job! You passed level number {level}'+ color.END)
            else:
                print(color.RED + f'You are dumb you could not pass level {level}'+ color.END)
        elif choice == '4':
            answer = input(color.BOLD + f'What is {num1} / {num2} = ' + color.END)
            if int(answer) == num1 // num2: # floor division
                print(color.GREEN + f'Good job! You passed level number {level}'+ color.END)
            else:
                print(color.RED + f'You are dumb you could not pass level {level}'+ color.END)
    else:
        print(color.RED + "Invalid Input" + color.END)
else:
    time.sleep(2)
    print(color.YELLOW + 'Game completed.. ' + color.END)

