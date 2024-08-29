
# Investigación sobre Conceptos de Sistemas Operativos

## Tipos de Kernel y sus diferencias

El kernel es la parte central del sistema operativo que gestiona las interacciones entre el hardware y el software. Existen varios tipos de kernels, cada uno con diferentes características y enfoques:

### 1. Kernel Monolítico
- **Descripción**: En un kernel monolítico, todas las funciones del sistema operativo (como manejo de archivos, administración de memoria, controladores de dispositivos, etc.) se ejecutan en un solo espacio de memoria. 
- **Ventajas**: Alto rendimiento debido a la comunicación directa entre componentes.
- **Desventajas**: Mayor riesgo de fallos, ya que un error en un componente puede afectar a todo el sistema.

### 2. Microkernel
- **Descripción**: Un microkernel mantiene solo las funciones más esenciales (como la comunicación interprocesos y la administración de la memoria) en el kernel, mientras que otras funciones del sistema operativo se ejecutan en el espacio de usuario.
- **Ventajas**: Mejor aislamiento de errores y mayor seguridad. Los servicios pueden reiniciarse sin afectar a todo el sistema.
- **Desventajas**: Menor rendimiento debido a la necesidad de más comunicación entre procesos en espacio de usuario y el kernel.

### 3. Kernel Híbrido
- **Descripción**: Combina elementos de los kernels monolíticos y microkernels. Generalmente mantiene la estructura monolítica pero modulariza algunas partes para mejorar la flexibilidad y seguridad.
- **Ventajas**: Balance entre rendimiento y seguridad. Ejemplos incluyen los kernels de Windows NT y macOS.
- **Desventajas**: Mayor complejidad en la implementación.

### 4. Exokernel
- **Descripción**: Este tipo de kernel delega la mayoría de las funciones a la capa de software sobre el kernel, ofreciendo solo las mínimas abstracciones de hardware necesarias. 
- **Ventajas**: Alta eficiencia y flexibilidad, permitiendo a los programas más control sobre los recursos.
- **Desventajas**: Complejidad en la programación de aplicaciones.

## User Mode vs Kernel Mode

El sistema operativo divide las operaciones en dos modos principales para proteger el sistema:

### Kernel Mode (Modo Kernel)
- **Descripción**: Es el modo privilegiado donde el sistema operativo tiene acceso completo a todos los recursos del hardware y puede ejecutar cualquier instrucción de la CPU.
- **Funciones**: Aquí se ejecutan las operaciones más críticas, como la administración de memoria, controladores de hardware, y el kernel del sistema operativo. 
- **Riesgos**: Los errores en modo kernel pueden llevar a fallos del sistema, ya que no hay restricciones sobre lo que se puede hacer.

### User Mode (Modo Usuario)
- **Descripción**: Es un modo restringido donde las aplicaciones de usuario se ejecutan. Las instrucciones que se pueden ejecutar y los recursos a los que se puede acceder están limitados.
- **Funciones**: Programas de usuario, como aplicaciones, se ejecutan en este modo. Cuando necesitan realizar operaciones que requieren privilegios, deben solicitar acceso al modo kernel a través de llamadas al sistema.
- **Ventajas**: Protege la integridad del sistema al evitar que programas de usuario puedan alterar el sistema directamente.

## Interruptions vs Traps

Ambos términos se refieren a mecanismos para manejar eventos que requieren la atención inmediata de la CPU, pero hay diferencias en cómo y por qué ocurren:

### Interruptions (Interrupciones)
- **Descripción**: Son señales enviadas por hardware o software que interrumpen el flujo de ejecución normal de la CPU para atender un evento de alta prioridad, como la entrada/salida de datos o un temporizador. 
- **Tipos**:
  - **Interrupciones de hardware**: Generadas por dispositivos periféricos, como teclados o discos duros.
  - **Interrupciones de software**: Generadas por el software, como una solicitud de servicio del sistema operativo.
- **Proceso**: Cuando ocurre una interrupción, la CPU pausa la ejecución actual, guarda el estado, y transfiere el control al manejador de interrupciones adecuado.

### Traps (Excepciones o Trampas)
- **Descripción**: Son interrupciones causadas por eventos que ocurren como resultado de la ejecución de instrucciones específicas en el código, como una operación ilegal o un error de software. Son generadas por el propio CPU en respuesta a condiciones excepcionales.
- **Ejemplos**: Errores de división por cero, violaciones de acceso a memoria, llamadas al sistema.
- **Proceso**: Similar a las interrupciones, pero usualmente implica una respuesta específica del sistema operativo para manejar la condición excepcional.

En resumen:
- **Interrupciones**: Son asíncronas y pueden ser generadas por hardware o software externo a la CPU.
- **Traps**: Son síncronas, generadas internamente por la CPU como resultado de instrucciones o errores en el código en ejecución.
