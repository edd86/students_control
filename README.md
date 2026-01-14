# Students Control 📚

Una aplicación Flutter completa para la gestión integral de estudiantes, cursos, docentes e inscripciones. Diseñada con arquitectura moderna, navegación avanzada y persistencia de datos local.

## Descripción General

**Students Control** es una aplicación de administración educativa que permite gestionar:
- 👥 Estudiantes y sus datos personales
- 📖 Cursos y su contenido
- 👨‍🏫 Docentes y sus asignaciones
- 📋 Inscripciones de estudiantes en cursos
- 📊 Dashboard con información general del sistema

## ✨ Características Principales

### 🔐 Autenticación
- Sistema de login seguro con contraseñas encriptadas usando bcrypt
- Validación de correo electrónico integrada
- Gestión de sesiones de usuario

### 👥 Gestión de Usuarios
- **Estudiantes**: Registro, edición y eliminación de estudiantes con información completa
- **Docentes**: Administración de docentes y sus asignaciones a cursos
- **Dashboard**: Vista general con estadísticas y resumen del sistema

### 📚 Gestión Académica
- **Cursos**: Crear, editar y eliminar cursos
- **Inscripciones**: Gestionar inscripciones de estudiantes en cursos
- **Búsqueda Avanzada**: Búsqueda animada para filtrar estudiantes, cursos y docentes

### 🎨 Interfaz de Usuario
- Diseño moderno y responsive
- Soporte para modo claro y oscuro (tema dinámico)
- Iconos SVG y recursos visuales optimizados
- Transiciones y animaciones suaves

### 💾 Persistencia de Datos
- Base de datos local SQLite
- Sincronización automática de datos
- Almacenamiento seguro de información sensible

### 🔄 Estado y Navegación
- Gestión de estado con Riverpod (Flutter Riverpod)
- Navegación declarativa con GoRouter
- Rutas nombradas para fácil navegación entre pantallas

## 🛠️ Tecnologías Utilizadas

### Framework & SDK
- **Flutter**: 3.9.2+
- **Dart**: 3.9.2+

### Dependencias Principales
```yaml
flutter_riverpod: ^3.0.3          # Gestión de estado
go_router: ^17.0.0                # Navegación
sqflite: ^2.4.2                   # Base de datos SQLite
bcrypt: ^1.1.3                    # Encriptación de contraseñas
flutter_svg: ^2.2.3               # Soporte para archivos SVG
email_validator: ^3.0.0           # Validación de emails
animated_search_bar: ^2.8.0       # Búsqueda animada
sqflite_common_ffi: ^2.3.6        # Soporte FFI para SQLite
```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada principal
├── core/
│   ├── constants/                 # Constantes de la aplicación
│   ├── database/                  # Configuración y helper de SQLite
│   ├── presentation/              # Widgets compartidos
│   ├── router/                    # Configuración de rutas (GoRouter)
│   ├── theme/                     # Temas (claro/oscuro)
│   └── utils/                     # Utilidades y helpers
└── features/
    ├── login/                     # Autenticación y login
    ├── dashboard/                 # Panel principal
    ├── students/                  # Gestión de estudiantes
    ├── teachers/                  # Gestión de docentes
    ├── courses/                   # Gestión de cursos
    └── enrollments/               # Gestión de inscripciones

assets/
├── images/svg/                    # Iconos y gráficos SVG
├── images/icons/                  # Iconos de la aplicación
└── images/png/                    # Imágenes PNG
```

## 🚀 Cómo Iniciar

### Requisitos Previos
- Flutter SDK 3.9.2 o superior
- Dart 3.9.2 o superior
- Un editor (VS Code, Android Studio, IntelliJ IDEA)

### Instalación

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd students_control
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

### Plataformas Soportadas
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 📱 Pantallas Principales

### 1. **Login**
- Formulario de autenticación con validación de email
- Contraseñas encriptadas para máxima seguridad

### 2. **Dashboard**
- Vista general del sistema
- Estadísticas de estudiantes, docentes y cursos
- Acceso rápido a todas las funcionalidades

### 3. **Estudiantes**
- Listado de todos los estudiantes
- Búsqueda animada para filtrar
- Crear, editar y eliminar estudiantes
- Vista de detalles del estudiante

### 4. **Docentes**
- Gestión completa de docentes
- Asignación a cursos
- Búsqueda y filtrado

### 5. **Cursos**
- Creación y administración de cursos
- Visualización de estudiantes inscritos
- Edición de información del curso

### 6. **Inscripciones**
- Gestión de inscripciones de estudiantes
- Asociar estudiantes a cursos
- Historial de inscripciones

## 🎯 Arquitectura

La aplicación utiliza una arquitectura limpia y modular:

- **Core**: Componentes compartidos y configuración global (tema, base de datos, rutas)
- **Features**: Módulos independientes por funcionalidad
- **State Management**: Riverpod para manejo centralizado del estado
- **Routing**: GoRouter para navegación declarativa
- **Database**: SQLite para persistencia local

## 🔒 Seguridad

- Encriptación de contraseñas con bcrypt
- Validación de emails integrada
- Almacenamiento local seguro con SQLite
- Validación de datos en formularios

## 🌐 Temas

La aplicación incluye soporte para:
- **Tema Claro**: Interfaz optimizada para luz natural
- **Tema Oscuro**: Interfaz optimizada para condiciones de baja luz
- **Cambio Dinámico**: Cambio de tema sin reiniciar la aplicación

## 📝 Notas de Desarrollo

- La base de datos se inicializa automáticamente en el primer lanzamiento
- Los datos se almacenan localmente en el dispositivo
- La aplicación es completamente offline (no requiere conexión a internet)
- Todos los formularios incluyen validación completa

## 🐛 Solución de Problemas

### La aplicación no inicia
```bash
flutter clean
flutter pub get
flutter run
```

### Errores de base de datos
- Limpiar la base de datos: `flutter run --verbose`
- Reinstalar la aplicación completamente

### Problemas de compilación
```bash
flutter doctor  # Verificar dependencias
flutter pub upgrade  # Actualizar paquetes
```

## 📄 Licencia

Este proyecto está disponible bajo la licencia MIT.

## 👨‍💻 Desarrollo

### Requisitos para Desarrolladores
- Flutter SDK 3.9.2+
- Editor recomendado: VS Code o Android Studio
- Plugins: Flutter, Dart, Pubspec Assist

### Ejecutar Tests
```bash
flutter test
```

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Contacto & Soporte

Para reportar bugs o sugerencias, crea un issue en el repositorio.

---

**Versión**: 0.1.0  
**Estado**: En Desarrollo 🚧  
**Última Actualización**: Enero 2026
