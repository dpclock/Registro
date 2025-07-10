# Sistema de Registro de Personal

Aplicación Flutter para gestión de personal y registro de cambios de trabajadores en proyectos de construcción.

## 🚀 Características

- **Gestión de Personal**: Registro de trabajadores con datos completos (NAF, IPF, empresa)
- **Seguimiento de Cambios**: Hasta 6 cambios por trabajador por mes
- **Múltiples Encargados**: DIONI, GERMAN, LUTE, VICTOR
- **Exportación**: Generación de PDFs y compartir archivos
- **Tiempo Real**: Sincronización con Firebase Firestore
- **Interfaz Moderna**: Diseño Material Design responsive

## 📱 Funcionalidades

### Pantallas Principales
- **Pantalla Principal**: Selección de encargados
- **Administración**: Gestión de registros y datos
- **Registro General**: Vista unificada con filtros
- **Gestión por Encargado**: Control mensual de cambios

### Gestión de Datos
- CRUD completo de trabajadores
- CRUD completo de proyectos
- Búsqueda y paginación
- Filtros por encargado y mes

## 🛠️ Tecnologías

- **Flutter**: Framework de desarrollo
- **Firebase**: Base de datos en tiempo real
- **PDF**: Generación de reportes
- **Material Design**: Interfaz de usuario

## 📋 Requisitos

- Flutter SDK ^3.7.2
- Firebase project configurado
- Dependencias listadas en `pubspec.yaml`

## 🚀 Instalación

1. Clona el repositorio
```bash
git clone [URL_DEL_REPOSITORIO]
cd registro
```

2. Instala las dependencias
```bash
flutter pub get
```

3. Configura Firebase
- Crea un proyecto en Firebase Console
- Descarga `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
- Coloca los archivos en las carpetas correspondientes

4. Ejecuta la aplicación
```bash
# Para web
flutter run -d chrome

# Para móvil
flutter run
```

## 📁 Estructura del Proyecto

```
registro/
├── lib/
│   └── main.dart          # Código principal de la aplicación
├── web/                   # Configuración web
├── pubspec.yaml           # Dependencias
└── README.md             # Este archivo
```

## 🔧 Configuración Firebase

La aplicación utiliza Firebase Firestore para:
- Almacenar cambios de trabajadores
- Sincronización en tiempo real
- Persistencia de datos

## 📊 Datos Predefinidos

### Trabajadores
- **TOLEBRICK**: 150+ trabajadores
- **SEANSA**: 100+ trabajadores

### Proyectos
- 80+ proyectos de construcción
- Principalmente AVINTIA y otras constructoras

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 📞 Soporte

Para soporte técnico o preguntas sobre el proyecto, contacta al equipo de desarrollo.
