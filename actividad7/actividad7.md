# Completely Fair Scheduler (CFS) en Linux

El **Completely Fair Scheduler (CFS)** es el planificador de procesos predeterminado del kernel de Linux, diseñado para ofrecer una asignación equitativa de la CPU entre todos los procesos. Introducido en la versión 2.6.23 del kernel, CFS busca mejorar la eficiencia y la justicia en la programación de procesos, sustituyendo al antiguo planificador O(1). A continuación se describen sus principales características y funcionamiento:

## 1. Objetivo de Equidad
El principal objetivo de CFS es ofrecer una distribución "completamente justa" del tiempo de CPU entre todos los procesos. Para lograr esto, el planificador asigna tiempos de ejecución de manera proporcional a la prioridad de cada proceso, pero intenta que cada proceso reciba su "parte justa" del tiempo de CPU. Los procesos de mayor prioridad recibirán más tiempo de CPU, pero todos los procesos activos tendrán acceso a la CPU.

## 2. Funcionamiento basado en tiempos virtuales
El CFS se basa en un **tiempo de ejecución virtual** para cada proceso. Este tiempo virtual mide cuánto tiempo ha usado el proceso la CPU en comparación con los demás. Los procesos que han usado menos tiempo de CPU tendrán un tiempo virtual más bajo, y por lo tanto, se les dará prioridad sobre los procesos que han utilizado más tiempo.

## 3. Árbol Rojo-Negro
CFS organiza los procesos en una estructura de **árbol rojo-negro**, que es un árbol de búsqueda binaria auto-balanceado. Esta estructura permite que el planificador encuentre el proceso que ha usado menos tiempo de CPU en un tiempo de búsqueda logarítmica O(log N), lo que hace que sea eficiente seleccionar el siguiente proceso a ejecutar.

## 4. Simplicidad en los intervalos de tiempo
CFS no utiliza el concepto tradicional de "ticks" del reloj de CPU para controlar cuánto tiempo se le asigna a cada proceso. En cambio, se basa en el **concepto de intervalo de tiempo ponderado**, que es más flexible y se ajusta en función de la carga del sistema y la prioridad del proceso. Esto le permite evitar el "desperdicio" de ciclos de CPU en procesos de baja prioridad o en ociosos.

## 5. Prioridades ponderadas
Aunque el objetivo es ser "justo", CFS utiliza un sistema de **prioridades ponderadas** para los procesos. Los procesos con mayor prioridad (menores valores de `nice`) reciben más tiempo de CPU, mientras que los de menor prioridad (mayores valores de `nice`) reciben menos. Sin embargo, incluso los procesos de baja prioridad reciben una parte de la CPU, asegurando que ningún proceso sea "hambreado" por completo.

## 6. Latencia mínima
CFS define un valor de **latencia mínima** para garantizar que cada proceso reciba una cantidad mínima de tiempo de CPU, incluso cuando hay muchos procesos activos. Este valor se ajusta dinámicamente según la cantidad de procesos en ejecución, garantizando que todos los procesos tengan una oportunidad justa de ejecutarse en un tiempo razonable.

## 7. Preempción
CFS permite la **preempción** de procesos. Si un proceso que ha usado más tiempo de CPU está ejecutándose y llega un nuevo proceso que ha usado menos tiempo de CPU, CFS preemptará al proceso en ejecución y asignará la CPU al nuevo proceso.

## 8. Soporte para múltiples núcleos
CFS está diseñado para funcionar eficientemente en sistemas con múltiples núcleos, distribuyendo las cargas de los procesos entre los diferentes núcleos de la CPU y asegurando que la asignación de CPU sea justa entre todos los procesos en todos los núcleos.

## Ventajas:
- **Equidad:** Todos los procesos reciben tiempo de CPU proporcional a su prioridad.
- **Escalabilidad:** Su estructura de árbol rojo-negro lo hace escalable para sistemas con muchos procesos.
- **Baja latencia:** Ofrece baja latencia en sistemas cargados, lo que mejora el rendimiento interactivo.

## Desventajas:
- **Sobrecarga de cálculo:** El uso de la estructura de árbol rojo-negro implica una sobrecarga computacional, que puede afectar el rendimiento en sistemas con muy alta carga de procesos.
- **No es estrictamente determinista:** Aunque es justo, el uso del tiempo virtual puede hacer que en algunos casos los procesos no obtengan un tiempo de CPU exactamente igual en todas las ejecuciones.

En resumen, el CFS de Linux es un planificador eficiente que busca ofrecer una asignación justa de tiempo de CPU, con soporte para sistemas modernos de múltiples núcleos y con una estructura diseñada para ser escalable y adaptable.
