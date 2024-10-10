# Kubernetes Local Cluster Setup

## 1. Instalación de un ambiente local de Kubernetes

### Opción 1: Usando Minikube

1. **Instalar Minikube**:
    - En Windows: Usar el paquete de instalación disponible en el sitio oficial.
    - En macOS: Usar Homebrew `brew install minikube`.
    - En Linux: Descargar el binario de Minikube y moverlo a una ubicación dentro del PATH.

2. **Instalar kubectl**:
    - `kubectl` es la herramienta para gestionar Kubernetes. Puedes instalarla con el siguiente comando:
    ```bash
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    ```

3. **Iniciar Minikube**:
    - Ejecuta el siguiente comando para iniciar Minikube:
    ```bash
    minikube start
    ```

### Opción 2: Usando Kind (Kubernetes in Docker)

1. **Instalar Kind**:
    - Si tienes Docker instalado, instala Kind con:
    ```bash
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    ```

2. **Crear un Cluster de Kubernetes**:
    ```bash
    kind create cluster
    ```

### Opción 3: Usando Docker Desktop

1. **Instalar Docker Desktop**:
    - Descarga e instala Docker Desktop. Durante la instalación, asegúrate de habilitar la opción de Kubernetes en la configuración.

2. **Iniciar Kubernetes**:
    - Activa Kubernetes en las preferencias de Docker Desktop y espera a que el cluster esté listo.

---

## 2. Desplegar un contenedor de un servidor web en Kubernetes

### Desplegar Apache o Nginx

1. **Crear un archivo de despliegue YAML**:
    - Crea un archivo `nginx-deployment.yaml` con el siguiente contenido:
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx:latest
            ports:
            - containerPort: 80
    ```

2. **Aplicar el archivo de despliegue**:
    - Ejecuta el siguiente comando para desplegar el servidor web:
    ```bash
    kubectl apply -f nginx-deployment.yaml
    ```

3. **Exponer el servicio**:
    - Expones el despliegue en un puerto accesible localmente:
    ```bash
    kubectl expose deployment nginx-deployment --type=NodePort --port=80
    ```

4. **Obtener la URL del servicio**:
    - Si estás usando Minikube, puedes obtener la URL del servicio con:
    ```bash
    minikube service nginx-deployment
    ```

---

## 3. Pregunta: ¿En un ambiente local de Kubernetes existen los nodos masters y workers, cómo es que esto funciona?

En un ambiente local de Kubernetes como Minikube, Kind o Docker Desktop, **todos los componentes de control y trabajo (masters y workers)** están empaquetados en una sola instancia o nodo para simplificar la configuración. Aunque en una implementación real de Kubernetes tendrías un clúster con varios nodos masters y workers distribuidos, en un entorno local, el nodo único puede asumir ambos roles. Esto significa que los componentes que gestionan el clúster (etcd, kube-apiserver, kube-scheduler, etc.) y los que ejecutan los contenedores (kubelet, kube-proxy) están presentes en una sola máquina.

