import math

def Calculate_Sum_With_Elements_In_Normal_Order():

    sum = 0
    index = 1

    while True:
        sum += pow(-1, index + 1) / index

        if (index % 999999 == 0):
            print("The sum by the index ", index, " is equal to:", sum)

        index = index + 1

def Calculate_Sum_With_Elements_In_Random_Order():

    normal_sum = 0
    random_sum = 0
    initial_index = 1
    index_for_the_randomness_of_the_sum = 3
    index_for_sum = 5

    while True:
        normal_sum += pow(-1, initial_index + 1) / initial_index
        random_sum += pow(-1, index_for_the_randomness_of_the_sum) / index_for_the_randomness_of_the_sum

        if (index_for_sum % 999999 == 0):
            print("The sum by the index ", index_for_sum, " is equal to:", normal_sum + random_sum)

        initial_index = initial_index + 1
        index_for_the_randomness_of_the_sum = index_for_the_randomness_of_the_sum + 3
        index_for_sum = index_for_sum + 5

def Menu():
    print("The program itself computes infinitly the sum for a serie of type: sum for n>=1 of (-1)^n+1 / n, "
          "which is equal to ln 2. Choose an option between 1 and 2,"
          "1. Doing the sum for the elements being picked in the right order."
          "AND"
          "2. Doing the sum for the elements being picked in a random order.")
    print("Introduce the option for choosing the type of sum to be displayed:")
    choosen_option = int(input())

    if (choosen_option != 1 and choosen_option != 2):
        while (choosen_option != 1 and choosen_option != 2):
            print("The option introduced is not valid. Please reintroduce the chosen option, deciding on:"
                  "1. Calling option 1. we compute the sum for its elements in normal order"
                  " OR "
                  "2. Calling option 1. we compute the sum for its elements in random order")
            choosen_option = int(input())

    print("The ln(2) is equal to:", math.log(2))


    if (choosen_option == 1):
        Calculate_Sum_With_Elements_In_Normal_Order()

    else:
            Calculate_Sum_With_Elements_In_Random_Order()

def Main_Program():
    Menu()

Main_Program()

