
# Actividad 6 - Procesos e Hilos
### 1. ¿Incluyendo el proceso inicial, cuántos procesos son creados por el siguiente programa?

### Respuesta:

- El comando fork() crea un nuevo proceso duplicado del proceso que lo llama. Cada llamada a fork() duplica el proceso actual.

- El primer fork() crea un proceso adicional (2 procesos en total: el original y uno nuevo).

- El segundo fork() se ejecuta en ambos procesos, creando dos procesos adicionales (4 procesos en total).

- El tercer fork() se ejecuta en los cuatro procesos existentes, creando cuatro procesos adicionales (8 procesos en total).

#### Total de procesos creados (incluyendo el proceso inicial): 8 procesos.


### 2. Escribir un programa en C que cree un proceso hijo (fork) que finalmente se convierta en un proceso zombie. Este proceso zombie debe permanecer en el sistema durante al menos 60 segundos.


```c
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    
    if (pid > 0) {
        // Proceso padre
        printf("Proceso padre (PID: %d)\n", getpid());
        sleep(60);  // Espera 60 segundos para que el hijo quede en estado zombie
    } else if (pid == 0) {
        // Proceso hijo
        printf("Proceso hijo (PID: %d)\n", getpid());
        _exit(0);  // Termina el hijo, creando un proceso zombie
    } else {
        // Error al hacer fork
        perror("fork");
        return 1;
    }
    
    return 0;
}

```


## Explicación:
- Este programa crea un proceso hijo que finaliza inmediatamente con _exit(0), mientras que el proceso padre espera 60 segundos.

- Durante ese tiempo, el proceso hijo está en estado zombie (estado en el que el proceso ha terminado, pero su entrada en la tabla de procesos no ha sido eliminada porque el proceso padre aún no ha llamado a wait() o waitpid()).

- Para verificar el proceso zombie, se puede usar el comando ```ps -l``` en la terminal mientras el programa está en ejecución.

## 3. Usando el siguiente código como referencia, completar el programa para que sea ejecutable y responder las siguientes preguntas:
- ¿Cuántos procesos únicos son creados?

    Hay 1 proceso padre y 1 proceso hijo, por lo tanto, se crean 2 procesos únicos.

 - ¿Cuántos hilos únicos son creados?

    Cada proceso (padre e hijo) crea 1 hilo único, por lo tanto, se crean 2 hilos únicos.



```C
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

void *hilo() {
    printf("Hilo creado (PID: %d)\n", getpid());
    pthread_exit(NULL);
}

int main() {
    pthread_t tid;
    pid_t pid;

    pid = fork();
    if (pid == 0) {
        // Proceso hijo
        printf("Proceso hijo (PID: %d)\n", getpid());
        pthread_create(&tid, NULL, hilo, NULL); // Crear hilo en el proceso hijo
        pthread_join(tid, NULL);  // Esperar a que el hilo termine
    } else if (pid > 0) {
        // Proceso padre
        printf("Proceso padre (PID: %d)\n", getpid());
        pthread_create(&tid, NULL, hilo, NULL); // Crear hilo en el proceso padre
        pthread_join(tid, NULL);  // Esperar a que el hilo termine
    } else {
        // Error al hacer fork
        perror("fork");
        return 1;
    }

    return 0;
}
```

Respuesta:
Número de hilos únicos creados: Cada proceso (padre e hijo) crea 1 hilo único, por lo tanto, se crean 2 hilos únicos.