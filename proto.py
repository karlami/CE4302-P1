import numpy as np

def filtrado_fir(x, b):
    Nx = len(x)
    Nb = len(b)
    
    x_padded = np.zeros(Nx + Nb - 1, dtype=np.int32)
    x_padded[:Nx] = x
    
    y = np.zeros(Nx, dtype=np.int32)
    
    # Convolución
    for n in range(Nx):
        for k in range(min(Nb, n + 1)):
            y[n] += b[k] * x_padded[n - k]  

    return y

if __name__ == "__main__":
    # Señal de entrada x y los coeficientes b en punto fijo Q7.8
    x = np.array([128, 64, 32, 16, 8, 4], dtype=np.int32)
    b = np.array([1, 2, 3, 4, 5], dtype=np.int32)

    # Filtrado FIR
    resultado = filtrado_fir(x, b)

    print("Señal de entrada:", x)
    print("Coeficientes:", b)
    print("Resultado del filtrado FIR:", resultado)
