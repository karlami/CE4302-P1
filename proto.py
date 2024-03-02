"""
Reference model that allows validating the correctness of the implementation of HW 
capable of performing FIR filtering of a vector x and coefficients b using the same 
Q7.8 fixed-point format and vectorization of the designed ISA.

"""

import numpy as np
from vector_generator import generate_vector
from coefficients_generator import generate_coefficients
#np.set_printoptions(threshold=np.inf) ## In case we want to see the whole vector in terminal

minimum = -127  # Minimum value for saturation
maximum = 127  # Maximum value for saturation

def save(data, name):
    """
    Saves 'data' in a file called 'name'.
    """
    with open(name, "w") as file:
        string_values = [str(value) for value in data]
        file.write(" ".join(string_values))
    print(name + " file created.")

def saturated(x):
    """
    Saturates the input value x between the minimum and maximum values.
    """
    return np.where(x > maximum, maximum, np.where(x < minimum, minimum, x))

def fir_filter(signal, coefficients):  
    """
    Applies a FIR filter to the input signal using the given coefficients.
    """

    # Check if the parameters have the right value and format
    if not np.all(signal.dtype == np.int16) or not np.all((signal >= -128) & (signal <= 127)):
        raise ValueError("Signal must be Q7.8 format (int16 values between -128 and 127)")
    if not np.all(coefficients.dtype == np.int16) or not np.all((coefficients >= -128) & (coefficients <= 127)):
        raise ValueError("Coefficients must be Q7.8 format (int16 values between -128 and 127)")

    signal_length = len(signal) 
    coefficients_length = len(coefficients)
    filtered_signal = np.zeros(signal_length)  # Float filtered signal

    for n in range(signal_length):
        auxiliary_signal = 0.0
        for k in range(coefficients_length):
            product = signal[n - k]/127 * coefficients[k]/127  # Signal * coefficient
            auxiliary_signal = auxiliary_signal + product

        filtered_signal[n] = auxiliary_signal

    q78_result = saturated(np.round(filtered_signal * 128).astype(np.int16))  # Q7.8 filtered signal
    return q78_result


if __name__ == "__main__":
    # Get the signal
    x = generate_vector()
    b = generate_coefficients(10) # Input is the size of the vector. 

    result = fir_filter(x, b)
    save(x, "Original signal")
    save(b, "Coefficients vector")
    save(result, "Filtered signal")

    # print("Input signal:", x)
    # print("Coefficients:", b)
    # print("FIR filtering result:", result)
