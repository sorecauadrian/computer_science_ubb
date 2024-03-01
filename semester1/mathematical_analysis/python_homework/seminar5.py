from math import log
import matplotlib.pyplot  # Must install this module before run the program


def alternatingHarmonicSeries(end: int, valuesOfPartialSum: list):
    # sum from 1 to 'end' of [ (-1)^(1 + n)/n ]
    partialSum = 0
    valuesOfPartialSum.clear()

    # 1 - (1/2) + (1/3) - (1/4) + (1/5) - (1/6) ..........

    for i in range(1, end + 1):
        partialSum += ((-1) ** (i + 1)) / i
        valuesOfPartialSum.append(partialSum)
    return partialSum


def alternatingHarmonicSeriesDifferentSummation(end: int, valuesOfPartialSum: list):
    # sum from 1 to 'end' of [ (-1)^(1 + n)/n ] using a different summation
    partialSum = 0
    valuesOfPartialSum.clear()

    # [1 - (1/2)] - (1/4) + [(1/3) - (1/6)] - (1/8) + [(1/5) - (1/10)] - (1/12) + .....
    #  => (1/2) * (1 - (1/2) + (1/3) - (1/4) + .....

    for i in range(1, end + 1, 2):
        partialSum += (1 / i) - (1 / (2 * i)) - (1 / (2 * i + 2))
        valuesOfPartialSum.append(partialSum)

    return partialSum


def start():
    naturalLogarithmOf2 = log(2)
    valueOfHarmonicSeriesAtEachStep = []
    while True:
        print("Press 1 for the graph of the initial order of summation in the alternating harmonic series.")
        print("Press 2 for the graph of the new order of summation in the alternating harmonic series.")
        print("Press 0 to exit.")

        option = input()

        if option == "1":
            partialSum = alternatingHarmonicSeries(100000, valueOfHarmonicSeriesAtEachStep)
            print(f"Value of log(2) is: {naturalLogarithmOf2} ")
            print(f"Value of alternating harmonic series for first 100000 elements using initial order of summation is: {partialSum}")

            matplotlib.pyplot.xlabel("X Axis")
            matplotlib.pyplot.ylabel("Y Axis")
            matplotlib.pyplot.title("The progression of the alternating harmonic series(1)")
            matplotlib.pyplot.plot(valueOfHarmonicSeriesAtEachStep, ".")
            matplotlib.pyplot.show()
            matplotlib.pyplot.close()

        elif option == "2":
            partialSum = alternatingHarmonicSeriesDifferentSummation(100000, valueOfHarmonicSeriesAtEachStep)
            print(f"Value of log(2)/2 is: {naturalLogarithmOf2 / 2} ")
            print(f"Value of alternating harmonic series for first 100000 elements using new order of summation is: {partialSum}")

            matplotlib.pyplot.xlabel("X Axis")
            matplotlib.pyplot.ylabel("Y Axis")
            matplotlib.pyplot.title("The progression of the alternating harmonic(2)")
            matplotlib.pyplot.plot(valueOfHarmonicSeriesAtEachStep, ".")
            matplotlib.pyplot.show()
            matplotlib.pyplot.close()

        elif option == "0":
            return
        else:
            print("Bad input !")


start()
