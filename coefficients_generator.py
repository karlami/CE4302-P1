"""
    Function generated to obtain the coefficients vector. 
    Vector contains random numbers between -1 and 1 represented as Q7.8    
  
"""

import numpy as np

def generate_coefficients(M):
  coefficients = np.random.uniform(-1, 1, size=M)
  coefficients = np.round(coefficients * 127).astype(np.int16) #Q7.8 representation
  return coefficients


if __name__ == "__main__":
    # Display information
    print("Example with 1:", generate_coefficients(1))
    print("Example with 100:", generate_coefficients(100))