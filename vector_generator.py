"""
    Function generated to obtain the input signal in Q7.8 format, 
    considering the duration in seconds and the sampling frequency.

"""

import numpy as np

def generate_vector():
    # Define the range of values
    min_value = -1
    max_value = 1

    # Define the duration and sampling frequency
    seconds = 5  # Duration of the signal
    sampling_frequency = 44100

    # Define the number of elements
    num_elements = seconds * sampling_frequency

    # Generate an array of random numbers in the specified range
    array = np.random.uniform(min_value, max_value, num_elements)

    # Convert the array to Q7.8 format
    array_q7_8 = np.round(array * 256).astype(np.int8) / 256
    
    return array_q7_8

if __name__ == "__main__":
    # Display information
    print("Total samples:", generate_vector())
    print("First 10 samples:", generate_vector()[:10])

    