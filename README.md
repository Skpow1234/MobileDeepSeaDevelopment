
# Tienda de Productos: Aplicación Flutter con Backend en FastAPI

Este proyecto consiste en una aplicación móvil desarrollada en **Flutter** para la gestión de productos en una tienda. La aplicación se conecta a un backend creado con **FastAPI**, permite autenticación, muestra productos de forma local o desde el backend, y cuenta con pruebas unitarias.

## Características del Proyecto

- **Autenticación:** Utiliza OAuth2 para validar las peticiones al backend.
- **Gestión de Productos:** Listado, detalle y búsqueda de productos.
- **Almacenamiento Local:** Almacena productos localmente si están disponibles para evitar llamadas innecesarias al backend.
- **Indicador de Carga:** Muestra un indicador de carga durante las operaciones asíncronas.
- **Pruebas Unitarias:** Implementación de pruebas para pantallas y servicios.

## Instalación y Configuración

### Requisitos Previos

- **Flutter SDK:** [Instrucciones de instalación](https://flutter.dev/docs/get-started/install)
- **FastAPI Backend:** El backend debe estar configurado y corriendo. [Guía del backend](https://github.com/Skpow1234/BackendDeepSeaDevelopment)

### Instalación del Proyecto Flutter

1. **Clona este repositorio:**

   ```bash
   git clone https://github.com/Skpow1234/MobileDeepSeaDevelopment
   cd Mobile-front/tienda_productos
   ```

2. **Instala las dependencias de Flutter:**

   ```bash
   flutter pub get
   ```

3. **Configura la URL del backend:**
   Abre el archivo `lib/services/api_service.dart` y actualiza la variable `_baseUrl` con la URL de tu backend.

   ```dart
   final String _baseUrl = 'http://localhost:8080'; 
   ```

4. **Ejecuta la aplicación:**
   Asegúrate de que tienes un dispositivo emulador o físico conectado y ejecuta:

   ```bash
   flutter run
   ```

### Generación de Archivos de Mocks

Para ejecutar las pruebas correctamente, necesitas generar los archivos de mocks utilizando `build_runner`:

1. **Instala las dependencias de desarrollo:** Asegúrate de que tienes `mockito` y `build_runner` configurados en el archivo `pubspec.yaml`.

   ```yaml
   dev_dependencies:
     mockito: ^5.0.17
     build_runner: ^2.0.0
   ```

2. **Ejecuta el generador de mocks:**

   ```bash
   flutter pub run build_runner build
   ```

   Esto generará los archivos necesarios para las pruebas, como `login_screen_test.mocks.dart` y `products_list_screen_test.mocks.dart`.

### Pruebas Unitarias

Para ejecutar las pruebas:

```bash
flutter test
```

Esto ejecutará todas las pruebas en la carpeta `test/` y mostrará los resultados en la terminal.

## Estructura del Proyecto

```plaintext
lib/
├── main.dart                  # Punto de entrada de la aplicación
├── models/                    # Modelos de datos (Product)
├── screens/                   # Pantallas principales (Login, Products List, Product Detail)
├── services/                  # Lógica de comunicación con el backend y almacenamiento local
├── widgets/                   # Widgets reutilizables (ProductCard)
└── test/                      # Pruebas unitarias
```

## Funcionalidades Implementadas

1. **Inicio de Sesión:**
   - Pantalla de inicio de sesión que valida credenciales contra el backend.
   - Almacena el token de autenticación de forma segura utilizando `flutter_secure_storage`.

2. **Listado de Productos:**
   - Muestra productos desde el almacenamiento local o el backend.
   - Permite filtrar productos por nombre en tiempo real.

3. **Detalle de Producto:**
   - Muestra información detallada de un producto seleccionado.

4. **Indicador de Carga:**
   - Se utiliza un `CircularProgressIndicator` mientras se realizan operaciones asíncronas.

5. **Pruebas Unitarias:**
   - Verifica el flujo de autenticación y las funcionalidades de la pantalla de productos.

## Notas Adicionales

- Si estás ejecutando el backend en una máquina distinta al emulador, utiliza la IP de tu máquina en lugar de `localhost` en el archivo `api_service.dart`.
- Configura correctamente los puertos y las reglas de firewall si estás ejecutando en un entorno remoto.

## Autor

### Juan Felipe Hurtado

Este proyecto fue desarrollado como parte de un ejercicio práctico para implementar una aplicación móvil conectada a un backend.
