"""
Reference model that allows validating the correctness of the implementation of HW 
capable of performing FIR filtering of a vector x and coefficients b using the same 
Q7.8 fixed-point format and vectorization of the designed ISA.

"""

import numpy as np
from vector_generator import generate_vector

minimum = -128  # Minimum value for saturation
maximum = 127  # Maximum value for saturation

def saturated(x):
    """
    Saturates the input value x between the minimum and maximum values.
    """
    return np.where(x > maximum, maximum, np.where(x < minimum, minimum, x))

def fir_filter(signal, coefficients):  
    """
    Applies a FIR filter to the input signal using the given coefficients.
    """
    signal_length = len(signal) 
    coefficients_length = len(coefficients)
    filtered_signal = np.zeros(signal_length)  # Float filtered signal

    for n in range(signal_length):
        auxiliary_signal = 0.0
        for k in range(coefficients_length):
            product = signal[n - k] * coefficients[k]  # Signal * coefficient
            auxiliary_signal = auxiliary_signal + product

        filtered_signal[n] = auxiliary_signal

    q78_result = saturated(np.round(filtered_signal * 128).astype(np.int16))  # Q7.8 filtered signal

    return q78_result

if __name__ == "__main__":
    # Get the signal
    x = generate_vector()
    b = np.array([0.01, 0.02, 0.03, 0.04, 0.05])

    result = fir_filter(x, b)

    print("Input signal:", x)
    print("Coefficients:", b)
    print("FIR filtering result:", result)
