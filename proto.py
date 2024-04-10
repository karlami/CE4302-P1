
"""
 Modelo de referencia que permita validar la correctitud de la implementación de HW
 capaz de realizar el filtrado FIR de un vector x y coeficientes b usando el mismo 
 formato de punto fijo Q7.8 y vectorización del ISA diseñado

"""

import numpy as np

minimo = -128
maximo = 127

def saturado(x):
    return np.where(x > maximo, maximo, np.where(x < minimo, minimo, x))

def filtrado_fir(senal, coeficientes):  
    longitud_senal = len(senal) 
    longitud_coeficientes = len(coeficientes)
    senal_filtrada = np.zeros(longitud_senal) # Señal filtrada en flotante

    for n in range(longitud_senal):
        senal_auxiliar = 0.0
        for k in range(longitud_coeficientes):
            producto = senal[n - k] * coeficientes[k] # Señal * coeficiente
            senal_auxiliar = senal_auxiliar + producto

        senal_filtrada[n] = senal_auxiliar

    resultado_q78 = saturado(np.round(senal_filtrada * 128).astype(np.int16)) # Señal filtrada a Q7.8

    return resultado_q78

if __name__ == "__main__":
    x = np.array([-8, -7, -6, -5, -4, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8])
    b = np.array([0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01, 0.011, 0.012, 0.013, 0.014, 0.015, 0.016])

    resultado = filtrado_fir(x, b)

    print("Señal de entrada:", x)
    print("Coeficientes:", b)
    print("Resultado del filtrado FIR:", resultado)

