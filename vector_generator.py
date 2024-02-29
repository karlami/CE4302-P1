"""
    Function generated to obtain the input signal in Q7.8 format, 
    considering the duration in seconds and the sampling frequency.

"""

import numpy as np

def generate_vector():
    # Parameters
    seconds = 5
    sampling_frequency = 44100

    # Calculate the total number of samples
    num_samples = seconds * sampling_frequency

    # Generate an array of time in seconds
    time = np.arange(0, seconds, 1/sampling_frequency)

    # Generate an array of sound samples in Q7.8 format
    sound_samples_q7_8 = np.array((np.sin(2 * np.pi * 440 * time) * 127).astype(np.int16), dtype=np.int16) << 8
    return sound_samples_q7_8[:10]

if __name__ == "__main__":
    # Display information
    print("Total number of samples:", generate_vector().size)
    print("Example of the first 10 samples:")
    # First 10 samples
    print(generate_vector())

    