import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAIndvoCzeUSNIC8F2VuA4QbyIWn3SdLy4",
          authDomain: "registro-app-369cf.firebaseapp.com",
          projectId: "registro-app-369cf",
          storageBucket: "registro-app-369cf.firebasestorage.app",
          messagingSenderId: "145687174734",
          appId: "1:145687174734:web:464da8cb3fd2f8f542ad1f",
          measurementId: "G-D4M121T49B",
        ),
      );
      print('Firebase inicializado correctamente en web');
    } catch (e) {
      print('Error inicializando Firebase en web: $e');
      print('La aplicación continuará sin Firebase. Algunas funciones pueden no estar disponibles.');
      // Continuar sin Firebase si hay error
    }
  } else {
    try {
      await Firebase.initializeApp();
      print('Firebase inicializado correctamente en móvil');
    } catch (e) {
      print('Error inicializando Firebase en móvil: $e');
      print('La aplicación continuará sin Firebase. Algunas funciones pueden no estar disponibles.');
    }
  }
  
  runApp(const RegistroApp());
}

class RegistroApp extends StatelessWidget {
  const RegistroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Personal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'REGISTRO DE CAMBIOS',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.engineering,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'SISTEMA DE GESTIÓN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Selecciona un encargado',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildEncargadoButton(
                            context,
                            'DIONI',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PantallaEncargado(encargado: 'DIONI')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildEncargadoButton(
                            context,
                            'GERMAN',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PantallaEncargado(encargado: 'GERMAN')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEncargadoButton(
                            context,
                            'LUTE',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PantallaEncargado(encargado: 'LUTE')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildEncargadoButton(
                            context,
                            'VICTOR',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PantallaEncargado(encargado: 'VICTOR')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PantallaAdmin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.admin_panel_settings, size: 20),
                  label: const Text(
                    'ADMINISTRACIÓN',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEncargadoButton(
    BuildContext context,
    String nombre,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
      child: Text(
        nombre,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PantallaAdmin extends StatelessWidget {
  const PantallaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'ADMINISTRACIÓN',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E3A8A).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'PANEL ADMINISTRATIVO',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    _buildAdminButton(
                      context,
                      'REGISTRO',
                      Icons.app_registration,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PantallaRegistroGeneral()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildAdminButton(
                      context,
                      'DATOS',
                      Icons.data_usage,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PantallaDatos()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF1F5F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF1E3A8A),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: const Color(0xFF1E3A8A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class PantallaDatos extends StatefulWidget {
  const PantallaDatos({super.key});

  @override
  State<PantallaDatos> createState() => _PantallaDatosState();
}

class _PantallaDatosState extends State<PantallaDatos> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'DATOS',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'TRABAJADORES'),
            Tab(text: 'PROYECTOS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTrabajadoresTab(),
          _buildProyectosTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            _agregarTrabajador(context);
          } else {
            _agregarProyecto(context);
          }
        },
        backgroundColor: const Color(0xFF1E3A8A),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTrabajadoresTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: listaTrabajadores.length,
          itemBuilder: (context, index) {
            final t = listaTrabajadores[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF1E3A8A), size: 32),
                title: Text(t["nombre"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("NAF: "+(t["naf"] ?? "")),
                    Text("IPF: "+(t["ipf"] ?? "")),
                    Text("Empresa: "+(t["empresa"] ?? ""), style: const TextStyle(color: Colors.indigo)),
                  ],
                ),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF1E3A8A)),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _editarTrabajador(context, index);
                    } else if (value == 'delete') {
                      _eliminarTrabajador(context, index);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xFF1E3A8A)),
                          SizedBox(width: 8),
                          Text('Editar'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Eliminar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProyectosTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: listaProyectos.length,
          itemBuilder: (context, index) {
            final p = listaProyectos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.business, color: Color(0xFF1E3A8A), size: 32),
                title: Text(p["proyecto"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Constructora: "+(p["constructora"] ?? ""), style: const TextStyle(color: Colors.indigo)),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF1E3A8A)),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _editarProyecto(context, index);
                    } else if (value == 'delete') {
                      _eliminarProyecto(context, index);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xFF1E3A8A)),
                          SizedBox(width: 8),
                          Text('Editar'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Eliminar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _editarTrabajador(BuildContext context, int index) {
    final trabajador = listaTrabajadores[index];
    final nombreController = TextEditingController(text: trabajador["nombre"]);
    final nafController = TextEditingController(text: trabajador["naf"]);
    final ipfController = TextEditingController(text: trabajador["ipf"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Trabajador'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nafController,
                decoration: const InputDecoration(
                  labelText: 'NAF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ipfController,
                decoration: const InputDecoration(
                  labelText: 'IPF',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                listaTrabajadores[index] = {
                  "nombre": nombreController.text,
                  "naf": nafController.text,
                  "ipf": ipfController.text,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trabajador actualizado'),
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _eliminarTrabajador(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar a ${listaTrabajadores[index]["nombre"]}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                listaTrabajadores.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trabajador eliminado'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _editarProyecto(BuildContext context, int index) {
    final proyecto = listaProyectos[index];
    final proyectoController = TextEditingController(text: proyecto["proyecto"]);
    final constructoraController = TextEditingController(text: proyecto["constructora"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Proyecto'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: proyectoController,
                decoration: const InputDecoration(
                  labelText: 'Proyecto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: constructoraController,
                decoration: const InputDecoration(
                  labelText: 'Constructora',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                listaProyectos[index] = {
                  "proyecto": proyectoController.text,
                  "constructora": constructoraController.text,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proyecto actualizado'),
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _eliminarProyecto(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar el proyecto ${listaProyectos[index]["proyecto"]}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                listaProyectos.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proyecto eliminado'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _agregarTrabajador(BuildContext context) {
    final nombreController = TextEditingController();
    final nafController = TextEditingController();
    final ipfController = TextEditingController();
    final empresaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Nuevo Trabajador'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nafController,
                decoration: const InputDecoration(
                  labelText: 'NAF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ipfController,
                decoration: const InputDecoration(
                  labelText: 'IPF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: empresaController,
                decoration: const InputDecoration(
                  labelText: 'Empresa',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nombreController.text.isNotEmpty) {
                setState(() {
                  listaTrabajadores.add({
                    "nombre": nombreController.text,
                    "naf": nafController.text,
                    "ipf": ipfController.text,
                    "empresa": empresaController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Trabajador agregado'),
                    backgroundColor: Color(0xFF1E3A8A),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El nombre es obligatorio'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _agregarProyecto(BuildContext context) {
    final proyectoController = TextEditingController();
    final constructoraController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Nuevo Proyecto'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: proyectoController,
                decoration: const InputDecoration(
                  labelText: 'Proyecto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: constructoraController,
                decoration: const InputDecoration(
                  labelText: 'Constructora',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (proyectoController.text.isNotEmpty) {
                setState(() {
                  listaProyectos.add({
                    "proyecto": proyectoController.text,
                    "constructora": constructoraController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Proyecto agregado'),
                    backgroundColor: Color(0xFF1E3A8A),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El nombre del proyecto es obligatorio'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

}

// --- Pantalla de Registro General ---
class PantallaRegistroGeneral extends StatefulWidget {
  const PantallaRegistroGeneral({super.key});

  @override
  State<PantallaRegistroGeneral> createState() => _PantallaRegistroGeneralState();
}

class _PantallaRegistroGeneralState extends State<PantallaRegistroGeneral> {
  final List<String> encargados = ['DIONI', 'GERMAN', 'LUTE', 'VICTOR'];
  final List<String> meses = [
    'ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO',
    'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'
  ];
  
  String encargadoSeleccionado = 'TODOS';
  String mesSeleccionado = 'TODOS';
  bool isLoading = false;
  List<Map<String, dynamic>> datosUnificados = [];

  @override
  void initState() {
    super.initState();
    _cargarDatosUnificados();
  }

  Future<void> _cargarDatosUnificados() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Map<String, dynamic>> todosLosDatos = [];

      for (String encargado in encargados) {
        for (String mes in meses) {
          final datos = await FirebaseService.cargarCambios('${encargado}_$mes');
          if (datos != null) {
            List<List<String?>> cambios = [];
            List<List<String?>> fechas = [];

            // Convertir datos de Firestore
            if (datos['cambios'] is Map && datos['fechas'] is Map) {
              Map<String, dynamic> cambiosMap = datos['cambios'] as Map<String, dynamic>;
              Map<String, dynamic> fechasMap = datos['fechas'] as Map<String, dynamic>;
              
              int i = 0;
              while (cambiosMap.containsKey('fila_$i')) {
                cambios.add(List<String?>.from(cambiosMap['fila_$i']));
                fechas.add(List<String?>.from(fechasMap['fila_$i']));
                i++;
              }
            } else {
              cambios = List<List<String?>>.from(datos['cambios'] ?? []);
              fechas = List<List<String?>>.from(datos['fechas'] ?? []);
            }

            // Procesar cada trabajador
            for (int i = 0; i < cambios.length && i < listaTrabajadores.length; i++) {
              // Buscar la última obra del trabajador
              String? ultimaObra;
              String? ultimaFecha;
              
              for (int j = 5; j >= 0; j--) {
                if (j < cambios[i].length && cambios[i][j] != null && cambios[i][j]!.isNotEmpty) {
                  ultimaObra = cambios[i][j];
                  ultimaFecha = j < fechas[i].length ? fechas[i][j] : null;
                  break;
                }
              }

              if (ultimaObra != null) {
                todosLosDatos.add({
                  'trabajador': listaTrabajadores[i]["nombre"] ?? "",
                  'encargado': encargado,
                  'mes': mes,
                  'ultimaObra': ultimaObra,
                  'fecha': ultimaFecha,
                });
              }
            }
          }
        }
      }

      setState(() {
        datosUnificados = todosLosDatos;
        isLoading = false;
      });
    } catch (e) {
      print('Error cargando datos unificados: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get datosFiltrados {
    return datosUnificados.where((dato) {
      bool encargadoOk = encargadoSeleccionado == 'TODOS' || dato['encargado'] == encargadoSeleccionado;
      bool mesOk = mesSeleccionado == 'TODOS' || dato['mes'] == mesSeleccionado;
      return encargadoOk && mesOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'REGISTRO GENERAL',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarDatosUnificados,
            tooltip: 'Actualizar datos',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Filtros
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filtros',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: encargadoSeleccionado,
                              decoration: const InputDecoration(
                                labelText: 'Encargado',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(value: 'TODOS', child: Text('TODOS')),
                                ...encargados.map((e) => DropdownMenuItem(value: e, child: Text(e))),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  encargadoSeleccionado = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: mesSeleccionado,
                              decoration: const InputDecoration(
                                labelText: 'Mes',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(value: 'TODOS', child: Text('TODOS')),
                                ...meses.map((m) => DropdownMenuItem(value: m, child: Text(m))),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  mesSeleccionado = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Resumen
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total de registros:',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '${datosFiltrados.length}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trabajadores activos:',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '${datosFiltrados.map((d) => d['trabajador']).toSet().length}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Lista de datos
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : datosFiltrados.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info_outline, size: 48, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'No hay datos para mostrar',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: datosFiltrados.length,
                            itemBuilder: (context, index) {
                              final dato = datosFiltrados[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF1E3A8A),
                                    child: Text(
                                      dato['trabajador'][0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    dato['trabajador'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Encargado: ${dato['encargado']}'),
                                      Text('Mes: ${dato['mes']}'),
                                      Text('Obra: ${dato['ultimaObra']}'),
                                      if (dato['fecha'] != null)
                                        Text(
                                          'Fecha: ${dato['fecha']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                          ),
                                        ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportData() async {
    try {
      if (datosFiltrados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay datos para exportar'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final pdf = pw.Document();
      
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) {
            List<pw.Widget> widgets = [];
            
            // Título
            widgets.add(
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Registro General - ${encargadoSeleccionado == 'TODOS' ? 'Todos los encargados' : encargadoSeleccionado} - ${mesSeleccionado == 'TODOS' ? 'Todos los meses' : mesSeleccionado}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );
            
            widgets.add(pw.SizedBox(height: 15));
            
            // Tabla de datos
            widgets.add(
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FixedColumnWidth(120), // TRABAJADOR
                  1: const pw.FixedColumnWidth(80),  // ENCARGADO
                  2: const pw.FixedColumnWidth(80),  // MES
                  3: const pw.FixedColumnWidth(150), // ÚLTIMA OBRA
                  4: const pw.FixedColumnWidth(80),  // FECHA
                },
                children: [
                  // Encabezados
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'TRABAJADOR',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'ENCARGADO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'MES',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'ÚLTIMA OBRA',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'FECHA',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // Datos
                  ...datosFiltrados.map((dato) => pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          dato['trabajador'],
                          style: const pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          dato['encargado'],
                          style: const pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          dato['mes'],
                          style: const pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          dato['ultimaObra'],
                          style: const pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          dato['fecha'] ?? '',
                          style: const pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            );
            
            return widgets;
          },
        ),
      );

      // Para web
      if (kIsWeb) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exportación web no disponible en esta versión'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        // Para móvil
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/registro_general_${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(await pdf.save());
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF guardado en: ${file.path}'),
            backgroundColor: const Color(0xFF1E3A8A),
          ),
        );
      }
    } catch (e) {
      print('Error exportando PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al exportar PDF'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// --- Pantalla para cada encargado ---
class PantallaEncargado extends StatefulWidget {
  final String encargado;
  const PantallaEncargado({super.key, required this.encargado});

  @override
  State<PantallaEncargado> createState() => _PantallaEncargadoState();
}

class _PantallaEncargadoState extends State<PantallaEncargado> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, String>> trabajadores;
  late List<String> proyectos;
  late List<List<String?>> cambios;
  late List<List<String?>> fechas; // Nueva lista para fechas
  int currentPage = 0;
  static const int itemsPerPage = 10;
  
  // Controlador para el buscador
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> trabajadoresFiltrados = [];
  
  // Lista de meses
  final List<String> meses = [
    'ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO',
    'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
    trabajadores = List<Map<String, String>>.from(listaTrabajadores);
    trabajadoresFiltrados = List<Map<String, String>>.from(listaTrabajadores);
    proyectos = listaProyectos.map((p) => p["proyecto"] ?? "").toList();
    cambios = List.generate(trabajadores.length, (_) => List.filled(6, null));
    fechas = List.generate(trabajadores.length, (_) => List.filled(6, null));
    
    // Agregar listener para cambiar de mes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _cargarDatosDelMesConCopia(meses[_tabController.index]);
      }
    });
    
    // Agregar listener para el buscador
    _searchController.addListener(_filtrarTrabajadores);
    
    // Cargar datos de Firebase
    _cargarDatosDeFirebase();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  void _filtrarTrabajadores() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        trabajadoresFiltrados = List<Map<String, String>>.from(trabajadores);
      } else {
        trabajadoresFiltrados = trabajadores.where((trabajador) {
          final nombre = trabajador["nombre"]?.toLowerCase() ?? "";
          return nombre.contains(query);
        }).toList();
      }
      currentPage = 0; // Resetear a la primera página al filtrar
    });
  }
  
  Future<void> _cargarDatosDeFirebase() async {
    try {
      // Cargar datos del mes actual (ENERO por defecto)
      final datos = await FirebaseService.cargarCambios('${widget.encargado}_ENERO');
      if (datos != null) {
        setState(() {
          cambios = List<List<String?>>.from(datos['cambios'] ?? []);
          fechas = List<List<String?>>.from(datos['fechas'] ?? []);
        });
      }
    } catch (e) {
      print('Error cargando datos de Firebase: $e');
    }
  }
  
  Future<void> _cargarDatosDelMes(String mes) async {
    try {
      final datos = await FirebaseService.cargarCambios('${widget.encargado}_$mes');
      if (datos != null) {
        setState(() {
          cambios = List<List<String?>>.from(datos['cambios'] ?? []);
          fechas = List<List<String?>>.from(datos['fechas'] ?? []);
        });
      } else {
        // Si no hay datos para este mes, inicializar listas vacías
        setState(() {
          cambios = List.generate(trabajadores.length, (_) => List.filled(6, null));
          fechas = List.generate(trabajadores.length, (_) => List.filled(6, null));
        });
      }
    } catch (e) {
      print('Error cargando datos del mes $mes: $e');
      // En caso de error, inicializar listas vacías
      setState(() {
        cambios = List.generate(trabajadores.length, (_) => List.filled(6, null));
        fechas = List.generate(trabajadores.length, (_) => List.filled(6, null));
      });
    }
  }

  Future<void> _cargarDatosDelMesConCopia(String mes) async {
    try {
      // Obtener el índice del mes actual
      final mesIndex = meses.indexOf(mes);
      
      // Si no es el primer mes (ENERO), intentar copiar del mes anterior
      if (mesIndex > 0) {
        final mesAnterior = meses[mesIndex - 1];
        
        // Cargar datos del mes anterior
        final datosMesAnterior = await FirebaseService.cargarCambios('${widget.encargado}_$mesAnterior');
        
        if (datosMesAnterior != null) {
          List<List<String?>> cambiosMesAnterior = [];
          List<List<String?>> fechasMesAnterior = [];
          
          // Convertir datos del mes anterior
          if (datosMesAnterior['cambios'] is Map && datosMesAnterior['fechas'] is Map) {
            Map<String, dynamic> cambiosMap = datosMesAnterior['cambios'] as Map<String, dynamic>;
            Map<String, dynamic> fechasMap = datosMesAnterior['fechas'] as Map<String, dynamic>;
            
            int i = 0;
            while (cambiosMap.containsKey('fila_$i')) {
              cambiosMesAnterior.add(List<String?>.from(cambiosMap['fila_$i']));
              fechasMesAnterior.add(List<String?>.from(fechasMap['fila_$i']));
              i++;
            }
          } else {
            cambiosMesAnterior = List<List<String?>>.from(datosMesAnterior['cambios'] ?? []);
            fechasMesAnterior = List<List<String?>>.from(datosMesAnterior['fechas'] ?? []);
          }
          
          // Cargar datos del mes actual
          final datosMesActual = await FirebaseService.cargarCambios('${widget.encargado}_$mes');
          
          if (datosMesActual != null) {
            // Convertir datos del mes actual
            if (datosMesActual['cambios'] is Map && datosMesActual['fechas'] is Map) {
              Map<String, dynamic> cambiosMap = datosMesActual['cambios'] as Map<String, dynamic>;
              Map<String, dynamic> fechasMap = datosMesActual['fechas'] as Map<String, dynamic>;
              
              List<List<String?>> cambiosConvertidos = [];
              List<List<String?>> fechasConvertidas = [];
              
              int i = 0;
              while (cambiosMap.containsKey('fila_$i')) {
                cambiosConvertidos.add(List<String?>.from(cambiosMap['fila_$i']));
                fechasConvertidas.add(List<String?>.from(fechasMap['fila_$i']));
                i++;
              }
              
              cambios = cambiosConvertidos;
              fechas = fechasConvertidas;
            } else {
              cambios = List<List<String?>>.from(datosMesActual['cambios'] ?? []);
              fechas = List<List<String?>>.from(datosMesActual['fechas'] ?? []);
            }
          } else {
            // Si no hay datos del mes actual, inicializar
            cambios = List.generate(trabajadores.length, (_) => List.filled(6, null));
            fechas = List.generate(trabajadores.length, (_) => List.filled(6, null));
          }
          
                     // NO copiar automáticamente las obras del mes anterior
                     // Los campos deben estar vacíos para que el usuario elija manualmente
                     // bool seHizoCambio = false;
                     // for (int i = 0; i < cambios.length && i < cambiosMesAnterior.length; i++) {
                     //   // Buscar la última obra escrita (la más a la derecha con datos)
                     //   String? ultimaObra;
                     //   
                     //   // Buscar desde el 6º cambio hacia atrás hasta encontrar la última obra escrita
                     //   for (int j = 5; j >= 0; j--) {
                     //     if (j < cambiosMesAnterior[i].length && 
                     //         cambiosMesAnterior[i][j] != null && 
                     //         cambiosMesAnterior[i][j]!.isNotEmpty) {
                     //       ultimaObra = cambiosMesAnterior[i][j];
                     //       break;
                     //     }
                     //   }
                     //   
                     //   // Si hay una última obra y el primer cambio del mes actual está vacío, copiarla
                     //   if (ultimaObra != null && (cambios[i][0] == null || cambios[i][0]!.isEmpty)) {
                     //     cambios[i][0] = ultimaObra;
                     //     fechas[i][0] = DateTime.now().toString().split(' ')[0]; // Fecha actual
                     //     seHizoCambio = true;
                     //     print('Copiando última obra de trabajador $i: $ultimaObra');
                     //   }
                     // }
                     // 
                     // // Si se hizo algún cambio, guardar en Firebase
                     // if (seHizoCambio) {
                     //   await FirebaseService.guardarCambios('${widget.encargado}_$mes', cambios, fechas);
                     // }
          
          setState(() {});
        } else {
          // Si no hay datos del mes anterior, cargar normalmente
          await _cargarDatosDelMes(mes);
        }
      } else {
        // Si es el primer mes (ENERO), cargar normalmente
        await _cargarDatosDelMes(mes);
      }
    } catch (e) {
      print('Error cargando datos del mes $mes con copia: $e');
      // En caso de error, cargar normalmente
      await _cargarDatosDelMes(mes);
    }
  }

  List<Map<String, String>> get currentPageItems {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, trabajadoresFiltrados.length);
    return trabajadoresFiltrados.sublist(startIndex, endIndex);
  }

  int get totalPages => (trabajadoresFiltrados.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encargado: ${widget.encargado}'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _exportData(),
            tooltip: 'Exportar datos',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          tabs: meses.map((mes) => Tab(text: mes)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: meses.map((mes) => _buildMesTab(mes)).toList(),
      ),
    );
  }

  Widget _buildMesTab(String mes) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Buscador por nombre
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Buscar trabajador por nombre',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tabla de Trabajadores - ${widget.encargado} - $mes',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Página ${currentPage + 1} de $totalPages (${trabajadoresFiltrados.length} trabajadores)',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseService.escucharCambios('${widget.encargado}_$mes'),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  final datos = snapshot.data!.data() as Map<String, dynamic>?;
                  if (datos != null) {
                    // Convertir de vuelta el formato de Firestore a listas anidadas
                    if (datos['cambios'] is Map && datos['fechas'] is Map) {
                      Map<String, dynamic> cambiosMap = datos['cambios'] as Map<String, dynamic>;
                      Map<String, dynamic> fechasMap = datos['fechas'] as Map<String, dynamic>;
                      
                      List<List<String?>> cambiosConvertidos = [];
                      List<List<String?>> fechasConvertidas = [];
                      
                      // Reconstruir las listas anidadas
                      int i = 0;
                      while (cambiosMap.containsKey('fila_$i')) {
                        cambiosConvertidos.add(List<String?>.from(cambiosMap['fila_$i']));
                        fechasConvertidas.add(List<String?>.from(fechasMap['fila_$i']));
                        i++;
                      }
                      
                      cambios = cambiosConvertidos;
                      fechas = fechasConvertidas;
                    } else {
                      // Formato antiguo (compatibilidad)
                      cambios = List<List<String?>>.from(datos['cambios'] ?? []);
                      fechas = List<List<String?>>.from(datos['fechas'] ?? []);
                    }
                  }
                }
                
                return ListView.builder(
                  itemCount: currentPageItems.length,
                  itemBuilder: (context, index) {
                    // Encontrar el índice correcto del trabajador en la lista original
                    final trabajadorActual = currentPageItems[index];
                    final actualIndex = trabajadores.indexWhere((t) => t["nombre"] == trabajadorActual["nombre"]);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentPageItems[index]["nombre"] ?? "",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 0, '1º', mes),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 1, '2º', mes),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 2, '3º', mes),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 3, '4º', mes),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 4, '5º', mes),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: _buildSimpleDropdown(actualIndex, 5, '6º', mes),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                child: const Text('Anterior'),
              ),
              Text('Página ${currentPage + 1} de $totalPages'),
              ElevatedButton(
                onPressed: currentPage < totalPages - 1
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleDropdown(int trabajadorIdx, int cambioIdx, String label, String mes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<String>(
            value: cambios[trabajadorIdx][cambioIdx],
            hint: const Text('', style: TextStyle(fontSize: 12, color: Colors.black)),
            isExpanded: true,
            underline: Container(),
            style: const TextStyle(fontSize: 12, color: Colors.black),
            items: [
              const DropdownMenuItem(value: null, child: Text('', style: TextStyle(fontSize: 12, color: Colors.black))),
              ...proyectos.map((p) => DropdownMenuItem(
                value: p, 
                child: Text(p, style: const TextStyle(fontSize: 12, color: Colors.black), overflow: TextOverflow.ellipsis)
              )).toList(),
            ],
            onChanged: (value) async {
              setState(() {
                cambios[trabajadorIdx][cambioIdx] = value;
                // Registrar la fecha cuando se selecciona un proyecto
                if (value != null && value.isNotEmpty) {
                  fechas[trabajadorIdx][cambioIdx] = DateTime.now().toString().split(' ')[0]; // Solo la fecha
                } else {
                  fechas[trabajadorIdx][cambioIdx] = null;
                }
              });
              
              // Guardar en Firebase con el mes correspondiente
              await FirebaseService.guardarCambios('${widget.encargado}_$mes', cambios, fechas);
            },
          ),
        ),
        // Mostrar la fecha si existe
        if (fechas[trabajadorIdx][cambioIdx] != null)
          Text(
            fechas[trabajadorIdx][cambioIdx]!,
            style: const TextStyle(fontSize: 8, color: Colors.blue),
          ),
      ],
    );
  }

  Future<void> _exportData() async {
    try {
      // Crear el PDF
      final pdf = pw.Document();
      
      // Agregar página al PDF
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) {
            List<pw.Widget> widgets = [];
            
            // Título
            widgets.add(
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Trabajadores - ${widget.encargado} - ${meses[_tabController.index]}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );
            
            widgets.add(pw.SizedBox(height: 15));
            
            // Tabla de datos con columnas ajustadas
            widgets.add(
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FixedColumnWidth(120), // NOMBRE
                  1: const pw.FixedColumnWidth(80),  // 1º CAMBIO
                  2: const pw.FixedColumnWidth(80),  // 2º CAMBIO
                  3: const pw.FixedColumnWidth(80),  // 3º CAMBIO
                  4: const pw.FixedColumnWidth(80),  // 4º CAMBIO
                  5: const pw.FixedColumnWidth(80),  // 5º CAMBIO
                  6: const pw.FixedColumnWidth(80),  // 6º CAMBIO
                },
                children: [
                  // Encabezados
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'NOMBRE',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '1º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '2º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '3º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '4º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '5º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '6º CAMBIO',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // Datos de trabajadores
                  ...trabajadores.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> trabajador = entry.value;
                    
                    return pw.TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            trabajador["nombre"] ?? "",
                            style: const pw.TextStyle(fontSize: 8),
                            textAlign: pw.TextAlign.left,
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][0] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][0] != null)
                                pw.Text(
                                  fechas[index][0]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][1] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][1] != null)
                                pw.Text(
                                  fechas[index][1]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][2] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][2] != null)
                                pw.Text(
                                  fechas[index][2]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][3] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][3] != null)
                                pw.Text(
                                  fechas[index][3]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][4] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][4] != null)
                                pw.Text(
                                  fechas[index][4]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                cambios[index][5] ?? "",
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center,
                              ),
                              if (fechas[index][5] != null)
                                pw.Text(
                                  fechas[index][5]!,
                                  style: const pw.TextStyle(fontSize: 6, color: PdfColors.blue),
                                  textAlign: pw.TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
            
            return widgets;
          },
        ),
      );

      if (kIsWeb) {
        // Para web: mostrar preview y descargar
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
          name: 'Trabajadores_${widget.encargado}',
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF generado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Para móvil: guardar y compartir
        final bytes = await pdf.save();
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'trabajadores_${widget.encargado}_$timestamp.pdf';
        final file = File('${directory.path}/$fileName');
        
        await file.writeAsBytes(bytes);
        
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Datos de trabajadores - ${widget.encargado}',
          subject: 'Exportación de datos - ${widget.encargado}',
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF exportado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al exportar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

// --- Servicio Firebase ---
class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Guardar cambios de un encargado
  static Future<void> guardarCambios(String encargado, List<List<String?>> cambios, List<List<String?>> fechas) async {
    try {
      // Convertir las listas anidadas a un formato compatible con Firestore
      Map<String, dynamic> cambiosMap = {};
      Map<String, dynamic> fechasMap = {};
      
      for (int i = 0; i < cambios.length; i++) {
        cambiosMap['fila_$i'] = cambios[i];
        fechasMap['fila_$i'] = fechas[i];
      }
      
      // Primero eliminar el documento existente para evitar conflictos
      await _firestore.collection('cambios').doc(encargado).delete();
      
      // Luego crear el nuevo documento con el formato correcto
      await _firestore.collection('cambios').doc(encargado).set({
        'cambios': cambiosMap,
        'fechas': fechasMap,
        'ultimaActualizacion': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error guardando cambios: $e');
    }
  }
  
  // Cargar cambios de un encargado
  static Future<Map<String, dynamic>?> cargarCambios(String encargado) async {
    try {
      final doc = await _firestore.collection('cambios').doc(encargado).get();
      if (doc.exists) {
        final data = doc.data()!;
        
        // Convertir de vuelta el formato de Firestore a listas anidadas
        if (data['cambios'] is Map && data['fechas'] is Map) {
          Map<String, dynamic> cambiosMap = data['cambios'] as Map<String, dynamic>;
          Map<String, dynamic> fechasMap = data['fechas'] as Map<String, dynamic>;
          
          List<List<String?>> cambios = [];
          List<List<String?>> fechas = [];
          
          // Reconstruir las listas anidadas
          int i = 0;
          while (cambiosMap.containsKey('fila_$i')) {
            cambios.add(List<String?>.from(cambiosMap['fila_$i']));
            fechas.add(List<String?>.from(fechasMap['fila_$i']));
            i++;
          }
          
          return {
            'cambios': cambios,
            'fechas': fechas,
            'ultimaActualizacion': data['ultimaActualizacion'],
          };
        }
        
        return data;
      }
      return null;
    } catch (e) {
      print('Error cargando cambios: $e');
      return null;
    }
  }
  
  // Escuchar cambios en tiempo real
  static Stream<DocumentSnapshot> escucharCambios(String encargado) {
    return _firestore.collection('cambios').doc(encargado).snapshots();
  }
}

// --- Listas globales de trabajadores y proyectos ---
List<Map<String, String>> listaTrabajadores = [
  // --- TOLEBRICK ---
  {"nombre": "NATHANAEL DIAZ VARGAS", "naf": "02 1032590630", "ipf": "60Y7696584Q", "empresa": "TOLEBRICK"},
  {"nombre": "PEDRO JUAN ARIAS NUÑEZ", "naf": "03 1076261024", "ipf": "1051237989S", "empresa": "TOLEBRICK"},
  {"nombre": "EDSON FABRICIO GARCIA PONCE", "naf": "04 1016262767", "ipf": "60X2684947L", "empresa": "TOLEBRICK"},
  {"nombre": "JEREMY FABRICIO GARCIA GUERRERO", "naf": "04 1035142708", "ipf": "1076660398H", "empresa": "TOLEBRICK"},
  {"nombre": "DANIEL DELGADO ALIVIA", "naf": "07 0081544816", "ipf": "1006248692Y", "empresa": "TOLEBRICK"},
  {"nombre": "AISSAM HADDOUI", "naf": "07 1023272987", "ipf": "60X3041058K", "empresa": "TOLEBRICK"},
  {"nombre": "VARINDER SINGH", "naf": "08 1145467309", "ipf": "60X4545290F", "empresa": "TOLEBRICK"},
  {"nombre": "PEDRO VAQUERO DIAZ", "naf": "10 0041826279", "ipf": "1028946506V", "empresa": "TOLEBRICK"},
  {"nombre": "JUAN JOSE DELGADO ALIVIA", "naf": "13 1001017855", "ipf": "1006251376E", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE FERNANDO RAMIREZ GUERRERO", "naf": "18 1084357141", "ipf": "60Z1645672G", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE HUMBERTO SILVA SOLANO", "naf": "18 1085314108", "ipf": "1055940312B", "empresa": "TOLEBRICK"},
  {"nombre": "SALVADOR PARRA VALLEJO", "naf": "23 1007579133", "ipf": "1075108057Q", "empresa": "TOLEBRICK"},
  {"nombre": "MANUEL NAVARRETE VALLEJO", "naf": "23 1008815275", "ipf": "1075119536H", "empresa": "TOLEBRICK"},
  {"nombre": "MIGUEL ANGEL PARRA VALLEJO", "naf": "23 1013154916", "ipf": "1075113052C", "empresa": "TOLEBRICK"},
  {"nombre": "JULIAN JIMENEZ BRAVO", "naf": "28 0298323793", "ipf": "1051896077G", "empresa": "TOLEBRICK"},
  {"nombre": "MIGUEL DAVILA MURILLO", "naf": "28 0336901000", "ipf": "1005261363K", "empresa": "TOLEBRICK"},
  {"nombre": "FIDEL LINARES GARCIA", "naf": "28 0378729117", "ipf": "1003838008K", "empresa": "TOLEBRICK"},
  {"nombre": "RAMON MUÑOZ HIDALGO", "naf": "28 0388912194", "ipf": "1009452676K", "empresa": "TOLEBRICK"},
  {"nombre": "JESUS RUBIO SUAREZ", "naf": "28 0394601347", "ipf": "1009454129W", "empresa": "TOLEBRICK"},
  {"nombre": "LUIS MIGUEL CERRO LOPEZ", "naf": "28 0399855414", "ipf": "1007483723Y", "empresa": "TOLEBRICK"},
  {"nombre": "RAMON MAGUILLA LOZANO", "naf": "28 0453635345", "ipf": "1044419383N", "empresa": "TOLEBRICK"},
  {"nombre": "MOHAMED AHADDOUCH", "naf": "28 0462221158", "ipf": "60X1301245C", "empresa": "TOLEBRICK"},
  {"nombre": "RAFAEL GONZALEZ REALES", "naf": "28 1014378244", "ipf": "1046843876Y", "empresa": "TOLEBRICK"},
  {"nombre": "DARWIN ENRIQUE TORRES RODRIGUEZ", "naf": "28 1078706321", "ipf": "1052900480C", "empresa": "TOLEBRICK"},
  {"nombre": "ROBINSON RAMON CAMILO AGUERO", "naf": "28 1101082100", "ipf": "1050765744Y", "empresa": "TOLEBRICK"},
  {"nombre": "MOHAMED AGHARRAD", "naf": "28 1107389019", "ipf": "60X2904967K", "empresa": "TOLEBRICK"},
  {"nombre": "OSWALDO DANIEL VACA PAREDES", "naf": "28 1109966387", "ipf": "1006342566V", "empresa": "TOLEBRICK"},
  {"nombre": "IVAN FABIAN INTRIAGO RONQUILLO", "naf": "28 1114644922", "ipf": "1050246084P", "empresa": "TOLEBRICK"},
  {"nombre": "RICHARD ALFREDO ROMAN CASTILLO", "naf": "28 1119898783", "ipf": "1051789179X", "empresa": "TOLEBRICK"},
  {"nombre": "MIGUEL ANGEL REIMUNDO OÑA", "naf": "28 1124859426", "ipf": "1050249979Q", "empresa": "TOLEBRICK"},
  {"nombre": "TEODOR IVANOV VELIKOV", "naf": "28 1130444202", "ipf": "60X4316345G", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE ANTONIO SIMBAÑA SALTO", "naf": "28 1135033716", "ipf": "1050364059Q", "empresa": "TOLEBRICK"},
  {"nombre": "EMILIO CEJAS GUARDIA", "naf": "28 1155352687", "ipf": "60X6759956A", "empresa": "TOLEBRICK"},
  {"nombre": "MAIKOL YORDI SEJAS BARBA", "naf": "28 1155354004", "ipf": "60Y1285849W", "empresa": "TOLEBRICK"},
  {"nombre": "ALFONSO RODRIGO CUSCO ESQUIVEL", "naf": "28 1161386188", "ipf": "1005975764L", "empresa": "TOLEBRICK"},
  {"nombre": "DANYER MARTIN ARIAS TRONCOSO", "naf": "28 1162810068", "ipf": "1060087739D", "empresa": "TOLEBRICK"},
  {"nombre": "AHMED EL AYADI", "naf": "28 1166590341", "ipf": "60X4751091G", "empresa": "TOLEBRICK"},
  {"nombre": "ZIAN EL AZOUZI", "naf": "28 1173719639", "ipf": "60X4091479D", "empresa": "TOLEBRICK"},
  {"nombre": "WILLIAMS ULICES CACERES GARCIA", "naf": "28 1174841203", "ipf": "1006342540Z", "empresa": "TOLEBRICK"},
  {"nombre": "MARCO ROLANDO PABON DEL SALTO", "naf": "28 1179563584", "ipf": "1051164323H", "empresa": "TOLEBRICK"},
  {"nombre": "MOHAMED EL AYADI", "naf": "28 1180848735", "ipf": "60X7004978Y", "empresa": "TOLEBRICK"},
  {"nombre": "MILTON BOLIVAR VALAREZO VELEZ", "naf": "28 1188184763", "ipf": "60X5577322Y", "empresa": "TOLEBRICK"},
  {"nombre": "CRISTOBAL ALFREDO CASTILLO CASTILLO", "naf": "28 1191321095", "ipf": "1051743306E", "empresa": "TOLEBRICK"},
  {"nombre": "OMAR JAIME RODRIGUEZ DURAND", "naf": "28 1196846762", "ipf": "1051155323B", "empresa": "TOLEBRICK"},
  {"nombre": "ROGELIO FERNANDO PINEDA ALVAREZ", "naf": "28 1198793836", "ipf": "1060406091H", "empresa": "TOLEBRICK"},
  {"nombre": "MARIO EDUARDO CONDOR PLACENCIA", "naf": "28 1200599551", "ipf": "60X5500378C", "empresa": "TOLEBRICK"},
  {"nombre": "JUAN ERMITE SENA FLORIAN", "naf": "28 1202533386", "ipf": "1050255752Q", "empresa": "TOLEBRICK"},
  {"nombre": "VERGINEL PATRU", "naf": "28 1205966176", "ipf": "60X6545812N", "empresa": "TOLEBRICK"},
  {"nombre": "AHMED GOUMAIRI", "naf": "28 1210714429", "ipf": "60X4432180B", "empresa": "TOLEBRICK"},
  {"nombre": "MYKOLA KUCHURYAN", "naf": "28 1212954422", "ipf": "60X6546560R", "empresa": "TOLEBRICK"},
  {"nombre": "PLACIDO MUÑOZ ZAPATA", "naf": "28 1215422565", "ipf": "1054390469T", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE ANTONIO ESTEVEZ GUZMAN", "naf": "28 1216950014", "ipf": "1051233034M", "empresa": "TOLEBRICK"},
  {"nombre": "MOHAMED BENAICHI", "naf": "28 1217801287", "ipf": "60X5385557S", "empresa": "TOLEBRICK"},
  {"nombre": "FAUSTINO CHOQUE ROJAS", "naf": "28 1221902064", "ipf": "60X6858442A", "empresa": "TOLEBRICK"},
  {"nombre": "VENTSISLAV IVANOV VELIKOV", "naf": "28 1223292396", "ipf": "60X5331788C", "empresa": "TOLEBRICK"},
  {"nombre": "FELIX VALLEJOS HEREDIA", "naf": "28 1226858057", "ipf": "1060063337X", "empresa": "TOLEBRICK"},
  {"nombre": "FRANCISCO JAVIER BRITO BELTRE", "naf": "28 1230137869", "ipf": "1003185989Y", "empresa": "TOLEBRICK"},
  {"nombre": "PAULA ISABEL GARCIA RODRIGO", "naf": "28 1237335269", "ipf": "1050765563D", "empresa": "TOLEBRICK"},
  {"nombre": "RIMY COLQUE PANOZO", "naf": "28 1239103703", "ipf": "60X7172720D", "empresa": "TOLEBRICK"},
  {"nombre": "ILIE LEORDEAN", "naf": "28 1242782831", "ipf": "60X6598285E", "empresa": "TOLEBRICK"},
  {"nombre": "RONALDT CONDORI VARGAS", "naf": "28 1254365641", "ipf": "60X7399028C", "empresa": "TOLEBRICK"},
  {"nombre": "IVAN ARIEL COPA PINTO", "naf": "28 1277071624", "ipf": "60X8910944P", "empresa": "TOLEBRICK"},
  {"nombre": "MARINICA VALER FURDUI", "naf": "28 1280892818", "ipf": "60X5560026Y", "empresa": "TOLEBRICK"},
  {"nombre": "ANDREY EMILOV UZUNOV", "naf": "28 1286991892", "ipf": "60X6525513E", "empresa": "TOLEBRICK"},
  {"nombre": "NOURDINE EZZIR", "naf": "28 1290345163", "ipf": "60X8376622E", "empresa": "TOLEBRICK"},
  {"nombre": "AHMED AGHARRAD", "naf": "28 1293888390", "ipf": "60X5669540V", "empresa": "TOLEBRICK"},
  {"nombre": "ESTEFANIA AGUADO GARCIA SILVESTRE", "naf": "28 1294270532", "ipf": "1049019034P", "empresa": "TOLEBRICK"},
  {"nombre": "ANGEL DAVID VIQUE VIQUE", "naf": "28 1304753404", "ipf": "60X8943429V", "empresa": "TOLEBRICK"},
  {"nombre": "AHMED EZZIR", "naf": "28 1305231229", "ipf": "60X9673656V", "empresa": "TOLEBRICK"},
  {"nombre": "ABDELLAH AGHARRAD", "naf": "28 1306146463", "ipf": "60X9443880B", "empresa": "TOLEBRICK"},
  {"nombre": "LUIS GEOVANNY LALANGUI AMAY", "naf": "28 1328439285", "ipf": "1003516885R", "empresa": "TOLEBRICK"},
  {"nombre": "KEVIN PATRICIO CUSCO ZAMBRANO", "naf": "28 1380598310", "ipf": "1006009827L", "empresa": "TOLEBRICK"},
  {"nombre": "FABIAN ALONSO RODRIGUEZ MEZA", "naf": "28 1414344711", "ipf": "1050632898P", "empresa": "TOLEBRICK"},
  {"nombre": "JAIME MARTINEZ RUBIO", "naf": "28 1441081749", "ipf": "1012795603J", "empresa": "TOLEBRICK"},
  {"nombre": "PASQUALE TUNDO", "naf": "28 1448821844", "ipf": "60Y4473722Y", "empresa": "TOLEBRICK"},
  {"nombre": "YERBY PINEDA AGRAMONTE", "naf": "28 1469700385", "ipf": "1002412055E", "empresa": "TOLEBRICK"},
  {"nombre": "DANIEL MANGUILLA GONZALEZ", "naf": "28 1474267065", "ipf": "1054663209Y", "empresa": "TOLEBRICK"},
  {"nombre": "FREDY JOSE ARAUJO RANGEL", "naf": "28 1477935281", "ipf": "1017552664F", "empresa": "TOLEBRICK"},
  {"nombre": "FRANCIS JULIO REYES MENDEZ", "naf": "28 1479027038", "ipf": "1006659033G", "empresa": "TOLEBRICK"},
  {"nombre": "ROBERT ANTONIO BELTRE VARGAS", "naf": "28 1479331475", "ipf": "1055045082X", "empresa": "TOLEBRICK"},
  {"nombre": "EDDY MAIKOL MALDONADO GUTIERREZ", "naf": "28 1491491134", "ipf": "1051026866D", "empresa": "TOLEBRICK"},
  {"nombre": "ALEX JONATAN VALLEJOS AGUAYO", "naf": "28 1505637471", "ipf": "60Y6082133G", "empresa": "TOLEBRICK"},
  {"nombre": "LISMAR MALDONADO GUTIERREZ", "naf": "28 1515250373", "ipf": "1055212284W", "empresa": "TOLEBRICK"},
  {"nombre": "FRANK ROMAN FLORES DUGARTE", "naf": "28 1519984074", "ipf": "1001866279J", "empresa": "TOLEBRICK"},
  {"nombre": "EDWIN PEREZ AGUILAR", "naf": "28 1528537050", "ipf": "60Y7658648F", "empresa": "TOLEBRICK"},
  {"nombre": "HEBER ALEXIS RAMIREZ ARDILA", "naf": "28 1530964171", "ipf": "1060232209Q", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE MANUEL GONZALEZ HERRERA", "naf": "28 1534993715", "ipf": "1060715456X", "empresa": "TOLEBRICK"},
  {"nombre": "JOSUE MACHACA BARON", "naf": "28 1540964164", "ipf": "60Y7859860S", "empresa": "TOLEBRICK"},
  {"nombre": "ELIEZER BELTRE FIGUEREO", "naf": "28 1542727140", "ipf": "1043880166F", "empresa": "TOLEBRICK"},
  {"nombre": "ESMAILYN ELIAS BELTRE MENDEZ", "naf": "28 1552737338", "ipf": "60Y8581717V", "empresa": "TOLEBRICK"},
  {"nombre": "DARIO ALBERTO HERRERA RODRIGUEZ", "naf": "28 1557079100", "ipf": "60Y6540035E", "empresa": "TOLEBRICK"},
  {"nombre": "IVAN CAMARA SEJAS", "naf": "28 1568738803", "ipf": "1053721267Y", "empresa": "TOLEBRICK"},
  {"nombre": "GEBER ALFONSO BELANDRIA MENDEZ", "naf": "28 1594532012", "ipf": "60Y9396459F", "empresa": "TOLEBRICK"},
  {"nombre": "HENDERSON DAVID SUAREZ PEREZ", "naf": "28 1594793609", "ipf": "1060765130G", "empresa": "TOLEBRICK"},
  {"nombre": "RUBEN FIGUEREO BELTRE", "naf": "28 1608861033", "ipf": "60Y9677948E", "empresa": "TOLEBRICK"},
  {"nombre": "ALEX MARCELO CHOQUE ROMERO", "naf": "28 1609778388", "ipf": "60Y9812670X", "empresa": "TOLEBRICK"},
  {"nombre": "OLINTO DANIEL PABON MOLINA", "naf": "28 1610546106", "ipf": "60Z0415063X", "empresa": "TOLEBRICK"},
  {"nombre": "ELBHER JESUS RAMIREZ PERNIA", "naf": "28 1611334634", "ipf": "60Z0274895G", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE ALEXIS ROA PEREZ", "naf": "28 1611579659", "ipf": "60Z0594240V", "empresa": "TOLEBRICK"},
  {"nombre": "LUIS MANUEL FERNANDEZ FIGUEREO", "naf": "28 1612941400", "ipf": "60Z0347439Y", "empresa": "TOLEBRICK"},
  {"nombre": "LUIS FERNANDO HERRERA RODRIGUEZ", "naf": "28 1615786631", "ipf": "60Z0261120Y", "empresa": "TOLEBRICK"},
  {"nombre": "ENDER LEONEL ANDRADE PEREZ", "naf": "28 1616840594", "ipf": "60Y9825033E", "empresa": "TOLEBRICK"},
  {"nombre": "JULIO HEREDIA RODRIGUEZ", "naf": "28 1617461802", "ipf": "60Z0223224Z", "empresa": "TOLEBRICK"},
  {"nombre": "FABIAN SISA BELTRE", "naf": "28 1619839009", "ipf": "60Z0736846T", "empresa": "TOLEBRICK"},
  {"nombre": "JESUS DANIEL SUAREZ PEREZ", "naf": "28 1619911050", "ipf": "60Z0058150B", "empresa": "TOLEBRICK"},
  {"nombre": "ELIAS ALBERTO SEVERINO MONTILLA", "naf": "28 1621255108", "ipf": "60Z0787074L", "empresa": "TOLEBRICK"},
  {"nombre": "ANOUAR AYADI", "naf": "28 1624426604", "ipf": "60Z0164082M", "empresa": "TOLEBRICK"},
  {"nombre": "ESIO DE JESUS DAVILA RAMIREZ", "naf": "28 1628690257", "ipf": "60Z1305777A", "empresa": "TOLEBRICK"},
  {"nombre": "KEIBER JESUS MEDINA PEREZ", "naf": "28 1629309643", "ipf": "60Z0837633R", "empresa": "TOLEBRICK"},
  {"nombre": "ANGEL ALIRIO RAMIREZ", "naf": "28 1633651809", "ipf": "60Z1074490G", "empresa": "TOLEBRICK"},
  {"nombre": "ELIECER LEODAN CASTRO OTERO", "naf": "28 1634631509", "ipf": "60Z1369075M", "empresa": "TOLEBRICK"},
  {"nombre": "ANGEL JESUS RAMIREZ PEREZ", "naf": "28 1634792365", "ipf": "60Z1072587X", "empresa": "TOLEBRICK"},
  {"nombre": "CARLOS JULIO REYES FELIZ", "naf": "28 1638929720", "ipf": "60Z0925970H", "empresa": "TOLEBRICK"},
  {"nombre": "ALBERTO ANDUJAR BELTRE", "naf": "28 1642825177", "ipf": "60Z1723998S", "empresa": "TOLEBRICK"},
  {"nombre": "DEILIN REYES BELTRE", "naf": "28 1642939355", "ipf": "60Z1775282D", "empresa": "TOLEBRICK"},
  {"nombre": "LUIS ALFONSO GUIRIGAY CONTRERAS", "naf": "28 1647725192", "ipf": "60Z1713360A", "empresa": "TOLEBRICK"},
  {"nombre": "WALTER XAVIER ROA CEGARRA", "naf": "28 1648703074", "ipf": "60Z0870918M", "empresa": "TOLEBRICK"},
  {"nombre": "RAYLE RUBEN RAMIREZ ROMERO", "naf": "28 1648720959", "ipf": "60Z1883254L", "empresa": "TOLEBRICK"},
  {"nombre": "FRANYER JOSUE CONTRERAS MONTILVA", "naf": "28 1649284064", "ipf": "60Z1776701W", "empresa": "TOLEBRICK"},
  {"nombre": "KEVIN VALLEJOS AGUADO", "naf": "28 1652626625", "ipf": "1055523976K", "empresa": "TOLEBRICK"},
  {"nombre": "RICARDO ALBERTO ROA PABON", "naf": "28 1652769596", "ipf": "60Z1988141A", "empresa": "TOLEBRICK"},
  {"nombre": "JESUS ALIRIO ROA REY", "naf": "28 1654450629", "ipf": "60Y9751986T", "empresa": "TOLEBRICK"},
  {"nombre": "FREDY JOSE HERNANDEZ PEREIRA", "naf": "28 1659668825", "ipf": "60Z2349017D", "empresa": "TOLEBRICK"},
  {"nombre": "DANIEL ANTONIO GARCIA GARCIA", "naf": "28 1660175447", "ipf": "60Z2357649Q", "empresa": "TOLEBRICK"},
  {"nombre": "JHON ALEXANDER PABON BUSTAMANTE", "naf": "28 1666035762", "ipf": "60Z2715773F", "empresa": "TOLEBRICK"},
  {"nombre": "EDGAR DAVID ROMERO CONTRERAS", "naf": "36 1072521124", "ipf": "60Z0208900L", "empresa": "TOLEBRICK"},
  {"nombre": "ISABELO DIAZ TENDERO APARICIO", "naf": "45 0031182794", "ipf": "1003815929E", "empresa": "TOLEBRICK"},
  {"nombre": "RAMON L TAPETADO FERNANDEZ", "naf": "45 0031189565", "ipf": "1003812781W", "empresa": "TOLEBRICK"},
  {"nombre": "ANTONIO FERNANDEZ MORA", "naf": "45 0031621318", "ipf": "1003815582C", "empresa": "TOLEBRICK"},
  {"nombre": "CIRILO PALOMINO ROMERO", "naf": "45 0031999416", "ipf": "1003813765C", "empresa": "TOLEBRICK"},
  {"nombre": "GONZALO GUTIERREZ PALOMINO", "naf": "45 0040310393", "ipf": "1070348253Q", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE ANGEL LOPEZ ALAMO", "naf": "45 0045606900", "ipf": "1003876817Y", "empresa": "TOLEBRICK"},
  {"nombre": "ELEUTERIO GOMEZ MORENO", "naf": "45 1000946389", "ipf": "1003846906H", "empresa": "TOLEBRICK"},
  {"nombre": "JOSE ANTONIO CAMPAYA TABACO", "naf": "45 1003077965", "ipf": "1070351320R", "empresa": "TOLEBRICK"},
  {"nombre": "JULIO FRANCISCO DOMENECH INFANTES", "naf": "45 1004178008", "ipf": "1070352205N", "empresa": "TOLEBRICK"},
  {"nombre": "JAMAL BENAICHI", "naf": "45 1004470119", "ipf": "60X2024568Q", "empresa": "TOLEBRICK"},
  {"nombre": "MIL0UD ZEHRAOUI OUMOUSA", "naf": "45 1022494436", "ipf": "1013339193K", "empresa": "TOLEBRICK"},
  {"nombre": "CARLOS LINARES MIGUEL", "naf": "45 1023187479", "ipf": "1070357951P", "empresa": "TOLEBRICK"},
  {"nombre": "SERGIO CASANOVA FERNANDEZ PEINADO", "naf": "45 1038055559", "ipf": "1070360527P", "empresa": "TOLEBRICK"},
  {"nombre": "HENDER IVAN SUAREZ RAMIREZ", "naf": "45 1049403448", "ipf": "1060340336C", "empresa": "TOLEBRICK"},
  {"nombre": "IBRAHIM BOUBEKEUR HAMICI", "naf": "45 1055723404", "ipf": "60Y0717043D", "empresa": "TOLEBRICK"},
  {"nombre": "SEGUNDO NELSON VALLADOLID LANCHE", "naf": "45 1058084645", "ipf": "60X5713455W", "empresa": "TOLEBRICK"},
  {"nombre": "CIRO IGNACIO HERNANDEZ GONZALEZ", "naf": "46 1074325459", "ipf": "1060066773L", "empresa": "TOLEBRICK"},
  // --- SEANSA ---
  {"nombre": "AMAJOU OULD EL ALMI AKKAOUI", "naf": "02 1012611660", "ipf": "1055516301M", "empresa": "SEANSA"},
  {"nombre": "ENRIQUE GARCIA RODRIGUEZ", "naf": "03 0099894977", "ipf": "1075702285Q", "empresa": "SEANSA"},
  {"nombre": "MOHAMED OHAJJI MOULAY", "naf": "04 1006245091", "ipf": "1054288571S", "empresa": "SEANSA"},
  {"nombre": "MOHAMED ANIYA EL MOKADE", "naf": "04 1021822988", "ipf": "1049995565M", "empresa": "SEANSA"},
  {"nombre": "PEDRO GARCIA MORENO GARCIA MIGUEL", "naf": "05 1003715092", "ipf": "1070353004Y", "empresa": "SEANSA"},
  {"nombre": "FRANCISCO JOSE PIÑERO LAGOS", "naf": "06 1011445067", "ipf": "1044787178Z", "empresa": "SEANSA"},
  {"nombre": "DIONISIO MADRIDEJOS ALAMO", "naf": "13 0039390708", "ipf": "1005653675E", "empresa": "SEANSA"},
  {"nombre": "JUAN MARTINEZ CARDOZO", "naf": "13 1014550870", "ipf": "1051757864K", "empresa": "SEANSA"},
  {"nombre": "MARIO ALBERTO MARTINEZ CARDOZO", "naf": "13 1020377136", "ipf": "1051751842W", "empresa": "SEANSA"},
  {"nombre": "PEDRO MONTERO MORENO", "naf": "16 0020581331", "ipf": "1070333673H", "empresa": "SEANSA"},
  {"nombre": "MIGUEL ANGEL PEREZ NAVAS", "naf": "19 1002113350", "ipf": "1070352714S", "empresa": "SEANSA"},
  {"nombre": "PEDRO JAVIER FLORES PORTANOVA", "naf": "19 1004615142", "ipf": "1070354491K", "empresa": "SEANSA"},
  {"nombre": "ANTONIO PARRA VALLEJO", "naf": "23 1013155017", "ipf": "1075113053K", "empresa": "SEANSA"},
  {"nombre": "JONAEL DIAZ VARGAS", "naf": "23 1054055166", "ipf": "60Y7696689Y", "empresa": "SEANSA"},
  {"nombre": "DIEGO HERNANDO PIZARRO DELGADO", "naf": "23 1054689205", "ipf": "60Y6411266F", "empresa": "SEANSA"},
  {"nombre": "JESUS VERBO GALAN", "naf": "28 0369324056", "ipf": "1070341896F", "empresa": "SEANSA"},
  {"nombre": "AGAPITO PINA SIERRA", "naf": "28 0373368754", "ipf": "1052087179E", "empresa": "SEANSA"},
  {"nombre": "JUAN JOSE SAMPEDRO MALDONADO", "naf": "28 0413307492", "ipf": "1008944670Q", "empresa": "SEANSA"},
  {"nombre": "FRANCISCO FERNANDEZ PARRA", "naf": "28 0450051904", "ipf": "1051937984M", "empresa": "SEANSA"},
  {"nombre": "JOSE RAMON SAGRA MENDOZA", "naf": "28 0451461333", "ipf": "1052978406E", "empresa": "SEANSA"},
  {"nombre": "VICTOR MANUEL ROMERAL PERULERO", "naf": "28 1027489614", "ipf": "1053403347S", "empresa": "SEANSA"},
  {"nombre": "JULIO JOSE BRIEGAS MARQUEZ", "naf": "28 1035988127", "ipf": "1046889162M", "empresa": "SEANSA"},
  {"nombre": "JORGE CERRO LOPEZ", "naf": "28 1036924882", "ipf": "1046863954M", "empresa": "SEANSA"},
  {"nombre": "ANTONIO ROMAN PEÑA", "naf": "28 1047864462", "ipf": "1055062118A", "empresa": "SEANSA"},
  {"nombre": "DAVID HERNANDEZ LOPEZ", "naf": "28 1067446338", "ipf": "1052984590L", "empresa": "SEANSA"},
  {"nombre": "DANIEL ARTURO SALVATIERRA ROMAN", "naf": "28 1079926400", "ipf": "1002719860H", "empresa": "SEANSA"},
  {"nombre": "JUAN MARTINEZ DUEÑAS", "naf": "28 1094434364", "ipf": "1006265341A", "empresa": "SEANSA"},
  {"nombre": "JUAN CARLOS ENCARNACION PINEDA", "naf": "28 1098145222", "ipf": "1050618472A", "empresa": "SEANSA"},
  {"nombre": "MIGUEL ANTONIO MATOS VILLA", "naf": "28 1104829936", "ipf": "1050551538E", "empresa": "SEANSA"},
  {"nombre": "SERGIO MORENO ARANDA", "naf": "28 1107618078", "ipf": "1003906521V", "empresa": "SEANSA"},
  {"nombre": "MHAMED EL BOUAZZATI", "naf": "28 1108595455", "ipf": "60X2875484R", "empresa": "SEANSA"},
  {"nombre": "MANUEL EDGAR BARZALLO NIVELO", "naf": "28 1134946113", "ipf": "60X3995929R", "empresa": "SEANSA"},
  {"nombre": "JACINTO IVAN DUTAN COLT", "naf": "28 1138211070", "ipf": "1051510685T", "empresa": "SEANSA"},
  {"nombre": "FERNAN ALONSO GOMEZ VANEGAS", "naf": "28 1149678591", "ipf": "1043882798V", "empresa": "SEANSA"},
  {"nombre": "DAVID ROMERAL PERULERO", "naf": "28 1151266866", "ipf": "1053404034N", "empresa": "SEANSA"},
  {"nombre": "SERGIO FILIBERTO TITE GUATO", "naf": "28 1151645570", "ipf": "1051185524J", "empresa": "SEANSA"},
  {"nombre": "JOSE JONATHAN MORA GUIJARRO", "naf": "28 1151656987", "ipf": "1049022903J", "empresa": "SEANSA"},
  {"nombre": "EPIDARO ENCARNACION PINEDA", "naf": "28 1153974984", "ipf": "1003476630L", "empresa": "SEANSA"},
  {"nombre": "JOSE DE LEON GERALDO", "naf": "28 1156018250", "ipf": "1054444454G", "empresa": "SEANSA"},
  {"nombre": "OSCAR ALEJANDRO SILVA YANES", "naf": "28 1156159104", "ipf": "1005732287C", "empresa": "SEANSA"},
  {"nombre": "JOVANY HERNANDEZ SANCHEZ", "naf": "28 1160408411", "ipf": "1051555309G", "empresa": "SEANSA"},
  {"nombre": "ABRAHAN AGUILAR SANMARTIN", "naf": "28 1162411055", "ipf": "1005946542F", "empresa": "SEANSA"},
  {"nombre": "MILTON MENDEZ MELENDEZ", "naf": "28 1163223936", "ipf": "1002713096Q", "empresa": "SEANSA"},
  {"nombre": "DAVID GARCIA PEÑA", "naf": "28 1172808344", "ipf": "1070355118G", "empresa": "SEANSA"},
  {"nombre": "DARWIN RICARDO BEDOYA BONE", "naf": "28 1173110963", "ipf": "60X6468483D", "empresa": "SEANSA"},
  {"nombre": "CRISTIAN RAUL MOSQUERA GALEANO", "naf": "28 1181008985", "ipf": "1005978812P", "empresa": "SEANSA"},
  {"nombre": "FAVIO VARGAS RIVERA", "naf": "28 1183804003", "ipf": "1002768291B", "empresa": "SEANSA"},
  {"nombre": "SIDIKI TRAORE", "naf": "28 1186917905", "ipf": "60X4575675D", "empresa": "SEANSA"},
  {"nombre": "WINSOR ALFREDO VARGAS LEDEZMA", "naf": "28 1190789215", "ipf": "60X6592239W", "empresa": "SEANSA"},
  {"nombre": "MOHAMED BENALI", "naf": "28 1196018929", "ipf": "60X5165200K", "empresa": "SEANSA"},
  {"nombre": "SAYON DIALLO", "naf": "28 1197131092", "ipf": "60X5256371C", "empresa": "SEANSA"},
  {"nombre": "RENE VARGAS RIVERA", "naf": "28 1205772176", "ipf": "1006689311Z", "empresa": "SEANSA"},
  {"nombre": "VICTOR MANUEL CRIOLLO TONATO", "naf": "28 1208745531", "ipf": "60X6482124B", "empresa": "SEANSA"},
  {"nombre": "YOBANNY LEBRON LEBRON", "naf": "28 1210937832", "ipf": "1055209738D", "empresa": "SEANSA"},
  {"nombre": "JESUS QUIROGA SANCHEZ", "naf": "28 1215098122", "ipf": "1054392509Q", "empresa": "SEANSA"},
  {"nombre": "EDWIN BERNARDO FLORES CAMACHO", "naf": "28 1221511337", "ipf": "1060347391Z", "empresa": "SEANSA"},
  {"nombre": "JOSE MARCOS HEREDIA GARCIA", "naf": "28 1222093135", "ipf": "1054695302Z", "empresa": "SEANSA"},
  {"nombre": "MARIO CESPEDES", "naf": "28 1224230973", "ipf": "60X6790083T", "empresa": "SEANSA"},
  {"nombre": "WILSON LEDEZMA TRUJILLO", "naf": "28 1227465420", "ipf": "60X7899100A", "empresa": "SEANSA"},
  {"nombre": "CRISTIAN JOSE PINEDA CARVAJAL", "naf": "28 1250723592", "ipf": "1051749334R", "empresa": "SEANSA"},
  {"nombre": "ABRAHAM MORA GUIJARRO", "naf": "28 1251473122", "ipf": "1049066183F", "empresa": "SEANSA"},
  {"nombre": "ABDELHAMID BENABDELLAH", "naf": "28 1258139244", "ipf": "60X5238185G", "empresa": "SEANSA"},
  {"nombre": "MIHAEL ANTONIO ABREU JAVIER", "naf": "28 1265565606", "ipf": "60X7733934T", "empresa": "SEANSA"},
  {"nombre": "JORGE HUMBERTO LIBERIO CARRANZA", "naf": "28 1270942335", "ipf": "1060329166M", "empresa": "SEANSA"},
  {"nombre": "ROMOLUT STELICA MARILA", "naf": "28 1280893929", "ipf": "60X8037515G", "empresa": "SEANSA"},
  {"nombre": "SEFERINO MARIA ABREU DOMINGUEZ", "naf": "28 1281506241", "ipf": "1051723430H", "empresa": "SEANSA"},
  {"nombre": "LUCIO SOLIS ZAMBRANA", "naf": "28 1288852979", "ipf": "1060792533Z", "empresa": "SEANSA"},
  {"nombre": "STERLING BERNARDO ALCANTARA REYES", "naf": "28 1302111768", "ipf": "1051744248K", "empresa": "SEANSA"},
  {"nombre": "MOHAMED BOUSSTTA", "naf": "28 1306012986", "ipf": "60X9152297E", "empresa": "SEANSA"},
  {"nombre": "CONSTANTIN ALEXANDRU DOMINTE", "naf": "28 1321290587", "ipf": "60X9241490K", "empresa": "SEANSA"},
  {"nombre": "ROBERT BELTRE SEGURA", "naf": "28 1329195885", "ipf": "1072008130Y", "empresa": "SEANSA"},
  {"nombre": "ABRAHAN AGUILAR ROBLES", "naf": "28 1372488706", "ipf": "1002722481V", "empresa": "SEANSA"},
  {"nombre": "HECTOR JULIO REYES MENDEZ", "naf": "28 1472062438", "ipf": "60Y5074327N", "empresa": "SEANSA"},
  {"nombre": "RICHARD FREIRE TRONCOSO", "naf": "28 1519283654", "ipf": "1060236649V", "empresa": "SEANSA"},
  {"nombre": "MIGUEL ANGEL SAUCEDO VILLEGAS", "naf": "28 1521362787", "ipf": "60Y7068995M", "empresa": "SEANSA"},
  {"nombre": "YOSMEL MARTI MORALES", "naf": "28 1531760177", "ipf": "60Y7528419G", "empresa": "SEANSA"},
  {"nombre": "CRISTIAN ANDRES TERAN ORELLANA", "naf": "28 1555405343", "ipf": "1060570748H", "empresa": "SEANSA"},
  {"nombre": "OSSAMA FAHIM", "naf": "28 1593046191", "ipf": "60Y8546301K", "empresa": "SEANSA"},
  {"nombre": "RAMON YVAN CARRERO", "naf": "28 1605153108", "ipf": "60Y9461639M", "empresa": "SEANSA"},
  {"nombre": "JONNAR ALBERTO GARCIA ALCEDO", "naf": "28 1614518355", "ipf": "60Y9783743V", "empresa": "SEANSA"},
  {"nombre": "VITELO SANCHEZ ROA", "naf": "28 1617587292", "ipf": "60Z0461322Q", "empresa": "SEANSA"},
  {"nombre": "ESTHEFANO FELIZ MENDEZ", "naf": "28 1621691911", "ipf": "60Z0804539G", "empresa": "SEANSA"},
  {"nombre": "RICHARD JOSE RAMIREZ MORILLO", "naf": "28 1621886618", "ipf": "60Z0375639P", "empresa": "SEANSA"},
  {"nombre": "MIGUEL ANGEL SILVA", "naf": "28 1637323156", "ipf": "60Z1167843T", "empresa": "SEANSA"},
  {"nombre": "ORLANDO ISAAC ROA ZAMBRANO", "naf": "28 1645059009", "ipf": "60Z1548629K", "empresa": "SEANSA"},
  {"nombre": "LUIS FERNANDO MOSQUERA ARARAT", "naf": "28 1647045182", "ipf": "60Z2001333Q", "empresa": "SEANSA"},
  {"nombre": "NEFER LEANDRO MONTILVA ROA", "naf": "28 1649202525", "ipf": "60Z1855379C", "empresa": "SEANSA"},
  {"nombre": "JEAN CARLOS PEREZ RAMIREZ", "naf": "28 1653570656", "ipf": "60Z2032979Z", "empresa": "SEANSA"},
  {"nombre": "YILBER FARLEY CARRERO CARRERO", "naf": "28 1666238957", "ipf": "60Z2744694V", "empresa": "SEANSA"},
  {"nombre": "FABIAN EDUARDO TORRES GAONA", "naf": "30 1032146891", "ipf": "1052909514S", "empresa": "SEANSA"},
  {"nombre": "CRUZ NOVILLO DIAZ", "naf": "45 0033220101", "ipf": "1003814475V", "empresa": "SEANSA"},
  {"nombre": "JUAN IGNACIO MONTERO RODRIGUEZ", "naf": "45 0034571936", "ipf": "1003819192L", "empresa": "SEANSA"},
  {"nombre": "ANGEL FUENTES LOZANO", "naf": "45 0035765945", "ipf": "1070341843T", "empresa": "SEANSA"},
  {"nombre": "ANTONIO ALAMO CASAS", "naf": "45 0038445165", "ipf": "1003844912W", "empresa": "SEANSA"},
  {"nombre": "VICENTE TAPETADO FERNANDEZ", "naf": "45 0038935522", "ipf": "1003842699C", "empresa": "SEANSA"},
  {"nombre": "EMILIANO MORENO GOMEZ", "naf": "45 0041444889", "ipf": "1003853957P", "empresa": "SEANSA"},
  {"nombre": "JUAN CARLOS MORENO FERNANDEZ", "naf": "45 0041874622", "ipf": "1006241599C", "empresa": "SEANSA"},
  {"nombre": "GERMAN DIAZ TENDE GOMEZ", "naf": "45 0041888665", "ipf": "1003839701N", "empresa": "SEANSA"},
  {"nombre": "DOMINGO MORA MORALES", "naf": "45 0042360935", "ipf": "1003860963E", "empresa": "SEANSA"},
  {"nombre": "ISIDORO MORENO GUTIERREZ", "naf": "45 0043010229", "ipf": "1006247198F", "empresa": "SEANSA"},
  {"nombre": "BERNARDO CAMUÑAS MORALES", "naf": "45 0043198165", "ipf": "1070347278F", "empresa": "SEANSA"},
  {"nombre": "MELCHOR DIAZ GOMEZ", "naf": "45 0045490601", "ipf": "1003877180R", "empresa": "SEANSA"},
  {"nombre": "JOSE MANUEL GARCIA RODRIGUEZ", "naf": "45 1000882836", "ipf": "1006255433P", "empresa": "SEANSA"},
  {"nombre": "ANGEL MIGUEL RODRIGUEZ GALAN", "naf": "45 1000884351", "ipf": "1003874278C", "empresa": "SEANSA"},
  {"nombre": "FRANCISCO SANTIAGO GARCIA", "naf": "45 1003440909", "ipf": "1046863982X", "empresa": "SEANSA"},
  {"nombre": "FERNANDO HERNANDEZ SONSECA SANTIAGO", "naf": "45 1003441010", "ipf": "1046864111R", "empresa": "SEANSA"},
  {"nombre": "JESUS CASAS ALCAZAR", "naf": "45 1008961522", "ipf": "1070352852S", "empresa": "SEANSA"},
  {"nombre": "IVAN MARTINEZ DUEÑAS", "naf": "45 1011635789", "ipf": "1070354479D", "empresa": "SEANSA"},
  {"nombre": "DAVID GUTIERREZ GALLEGO", "naf": "45 1012091891", "ipf": "1070353516N", "empresa": "SEANSA"},
  {"nombre": "JOSE LUIS GUTIERREZ GALLEGO", "naf": "45 1012091992", "ipf": "1070353515B", "empresa": "SEANSA"},
  {"nombre": "DAVID BRAZAL PEÑA", "naf": "45 1012470902", "ipf": "1003916019Q", "empresa": "SEANSA"},
  {"nombre": "ANGEL GALLEGO GONZALEZ", "naf": "45 1016363935", "ipf": "1070355564J", "empresa": "SEANSA"},
  {"nombre": "JUAN MANUEL GALLEGO GONZALEZ", "naf": "45 1017253507", "ipf": "1070355565Z", "empresa": "SEANSA"},
  {"nombre": "SERGIO FERNANDEZ ROMERO", "naf": "45 1018153482", "ipf": "1003919452E", "empresa": "SEANSA"},
  {"nombre": "ANGEL GALLEGO DE LA CRUZ", "naf": "45 1019416304", "ipf": "1070352822P", "empresa": "SEANSA"},
  {"nombre": "CONSTANTIN DOMINTE", "naf": "45 1022173629", "ipf": "60X6881430Z", "empresa": "SEANSA"},
  {"nombre": "RODRIGO PEREZ NAVAS", "naf": "45 1022756033", "ipf": "1070356147K", "empresa": "SEANSA"},
  {"nombre": "ABOU EL KACEM HASSANI", "naf": "45 1023514956", "ipf": "60X6932424V", "empresa": "SEANSA"},
  {"nombre": "AHMED OUENNANI", "naf": "45 1024290754", "ipf": "60X7693435G", "empresa": "SEANSA"},
  {"nombre": "JESUS DEL CERRO TAVIRA", "naf": "45 1038582389", "ipf": "1050567130C", "empresa": "SEANSA"},
  {"nombre": "MOHAMED ALI DAHOURI", "naf": "45 1050531981", "ipf": "60Y7757738J", "empresa": "SEANSA"},
  {"nombre": "XAVIER ARGENIS HERNADEZ LINARES", "naf": "47 1042845812", "ipf": "60Z1921024T", "empresa": "SEANSA"},
];

List<Map<String, String>> listaProyectos = [
  {"proyecto": "210 viviendas Cañaveral", "constructora": "AVINTIA"},
  {"proyecto": "39 Chalets Julian Camarillo", "constructora": "AVINTIA"},
  {"proyecto": "45 viviendas Rivas", "constructora": "AVINTIA"},
  {"proyecto": "130 viviendas Villaverde", "constructora": "AVINTIA"},
  {"proyecto": "Hotel Las Tablas", "constructora": "AVINTIA"},
  {"proyecto": "96 viviendas Cañaveral", "constructora": "AVINTIA"},
  {"proyecto": "192 Lofts San Sebastian", "constructora": "AVINTIA"},
  {"proyecto": "90 viviendas Villaverde", "constructora": "AVINTIA"},
  {"proyecto": "Reforma centro de menores", "constructora": "AVINTIA"},
  {"proyecto": "143 viviendas Carabanchel", "constructora": "AVINTIA"},
  {"proyecto": "106 viviendas Los Berrocales", "constructora": "AVINTIA"},
  {"proyecto": "36 viviendas Peñagrande", "constructora": "AVINTIA"},
  {"proyecto": "261 Tres Cantos", "constructora": "AVINTIA"},
  {"proyecto": "65 viviendas Valdebebas", "constructora": "AVINTIA"},
  {"proyecto": "176 viviendas Pozuelo", "constructora": "AVINTIA"},
  {"proyecto": "134 viviendas Los Berrocales", "constructora": "AVINTIA"},
  {"proyecto": "8 viviendas Boadilla", "constructora": "AVINTIA"},
  {"proyecto": "14 viviendas Boadilla", "constructora": "AVINTIA"},
  {"proyecto": "38 viviendas Tres Cantos", "constructora": "AVINTIA"},
  {"proyecto": "53 viviendas Valdemoro", "constructora": "AVINTIA"},
  {"proyecto": "160 viviendas Meco", "constructora": "AVINTIA"},
  {"proyecto": "39 viviendas Getafe", "constructora": "AVINTIA"},
  {"proyecto": "104 viviendas Vallecas", "constructora": "AVINTIA"},
  {"proyecto": "57 viviendas Leganes", "constructora": "AVINTIA"},
  {"proyecto": "61 viviendas Humanes", "constructora": "AVINTIA"},
  {"proyecto": "124 viviendas Parla", "constructora": "AVINTIA"},
  {"proyecto": "80 viviendas Arroyofresno", "constructora": "AVINTIA"},
  {"proyecto": "42 viviendas Arroyofresno", "constructora": "AVINTIA"},
  {"proyecto": "143 viviendas Alcala", "constructora": "AVINTIA"},
  {"proyecto": "96 viviendas La Finca", "constructora": "AVINTIA"},
  {"proyecto": "73 viviendas Navalcarnero", "constructora": "AVINTIA"},
  {"proyecto": "113 viviendas Arganda", "constructora": "AVINTIA"},
  {"proyecto": "84 viviendas Cañaveral", "constructora": "AVINTIA"},
  {"proyecto": "Nueva sede ONCE", "constructora": "AVINTIA"},
  {"proyecto": "40 viviendas Las Rozas", "constructora": "AVINTIA"},
  {"proyecto": "18 viviendas Boadilla del Monte", "constructora": "AVINTIA"},
  {"proyecto": "134 viviendas Leganes", "constructora": "AVINTIA"},
  {"proyecto": "Residencia Casa verde", "constructora": "AVINTIA"},
  {"proyecto": "88 viviendas Planetario", "constructora": "AVINTIA"},
  {"proyecto": "107 viviendas Fernandez Caro", "constructora": "AVINTIA"},
  {"proyecto": "92 viviendas Valdebebas", "constructora": "AVINTIA"},
  {"proyecto": "22 viviendas paseo de los Canónigos", "constructora": "AVINTIA"},
  {"proyecto": "15 viviendas", "constructora": "AVINTIA"},
  {"proyecto": "21 viviendas", "constructora": "AVINTIA"},
  {"proyecto": "26 viviendas Carabanchel", "constructora": "AVINTIA"},
  {"proyecto": "158 viviendas Arganda", "constructora": "AVINTIA"},
  {"proyecto": "Oficinas calle Pradillo", "constructora": "AVINTIA"},
  {"proyecto": "164 viviendas Cañaveral", "constructora": "AVINTIA"},
  {"proyecto": "39 viviendas Boadilla", "constructora": "AVINTIA"},
  {"proyecto": "318 viviendas Navalcarnero", "constructora": "AVINTIA"},
  {"proyecto": "108 viviendas Leganes", "constructora": "AVINTIA"},
  {"proyecto": "150 viviendas Valdemoro", "constructora": "AVINTIA"},
  {"proyecto": "60 viviendas Villanueva del Pardillo", "constructora": "AVINTIA"},
  {"proyecto": "48 viviendas Villaviciosa de Odon", "constructora": "AVINTIA"},
  {"proyecto": "19 viviendas Villanueva del Pardillo", "constructora": "AVINTIA"},
  {"proyecto": "56 viviendas Alcala", "constructora": "AVINTIA"},
  {"proyecto": "106 viviendas Alto Arenal", "constructora": "AVINTIA"},
  {"proyecto": "24 viviendas La Finca", "constructora": "AVINTIA"},
  {"proyecto": "48 viviendas Villaverde", "constructora": "AVINTIA"},
  {"proyecto": "106 viviendas Vallecas", "constructora": "AVINTIA"},
  {"proyecto": "CONSTRUCTORA", "constructora": "CONSTRUCTORA"},
  {"proyecto": "AVINTIA", "constructora": "AVINTIA"},
  {"proyecto": "ARPADA", "constructora": "ARPADA"},
  {"proyecto": "ASENTIS", "constructora": "ASENTIS"},
  {"proyecto": "ALZA", "constructora": "ALZA"},
  {"proyecto": "DRAGADOS", "constructora": "DRAGADOS"},
  {"proyecto": "C SAN MARTIN", "constructora": "C SAN MARTIN"},
  {"proyecto": "C LOS ALAMOS", "constructora": "C LOS ALAMOS"},
  {"proyecto": "SACYR", "constructora": "SACYR"},
  {"proyecto": "MARCO", "constructora": "MARCO"},
  {"proyecto": "FCC", "constructora": "FCC"},
  {"proyecto": "AZVI", "constructora": "AZVI"},
  {"proyecto": "JARQUIL", "constructora": "JARQUIL"},
  {"proyecto": "ASCH", "constructora": "ASCH"},
  {"proyecto": "MCM", "constructora": "MCM"},
  {"proyecto": "PECSA", "constructora": "PECSA"},
  {"proyecto": "COTOLMA", "constructora": "COTOLMA"},
  {"proyecto": "ESPIREA", "constructora": "ESPIREA"},
  {"proyecto": "Oficinas calle Pradillo", "constructora": "Oficinas calle Pradillo"},
  {"proyecto": "164 viviendas Cañaveral", "constructora": "164 viviendas Cañaveral"},
  {"proyecto": "39 viviendas Boadilla", "constructora": "39 viviendas Boadilla"},
  {"proyecto": "318 viviendas Navalcarnero", "constructora": "318 viviendas Navalcarnero"},
  {"proyecto": "108 viviendas Leganes", "constructora": "108 viviendas Leganes"},
  {"proyecto": "150 viviendas Valdemoro", "constructora": "150 viviendas Valdemoro"},
  {"proyecto": "60 viviendas Villanueva del Pardillo", "constructora": "60 viviendas Villanueva del Pardillo"},
  {"proyecto": "48 viviendas Villaviciosa de Odon", "constructora": "48 viviendas Villaviciosa de Odon"},
  {"proyecto": "19 viviendas Villanueva del Pardillo", "constructora": "19 viviendas Villanueva del Pardillo"},
  {"proyecto": "56 viviendas Alcala", "constructora": "56 viviendas Alcala"},
  {"proyecto": "106 viviendas Alto Arenal", "constructora": "106 viviendas Alto Arenal"},
  {"proyecto": "24 viviendas La Finca", "constructora": "24 viviendas La Finca"},
  {"proyecto": "48 viviendas Villaverde", "constructora": "48 viviendas Villaverde"},
  {"proyecto": "106 viviendas Vallecas", "constructora": "106 viviendas Vallecas"},
  {"proyecto": "ACCIONA", "constructora": "ACCIONA"},
  {"proyecto": "UTE CAÑAVERAL (FTC Y ABECONSA)", "constructora": "UTE CAÑAVERAL (FTC Y ABECONSA)"},
  {"proyecto": "CEOS", "constructora": "CEOS"},
  {"proyecto": "CONSTRUCTORA SAN JOSE", "constructora": "CONSTRUCTORA SAN JOSE"},
  {"proyecto": "TMR", "constructora": "TMR"},
  {"proyecto": "GARCIA DE CELIS", "constructora": "GARCIA DE CELIS"},
  {"proyecto": "LARVIN", "constructora": "LARVIN"},
  {"proyecto": "CHM", "constructora": "CHM"},
  {"proyecto": "MLN", "constructora": "MLN"},
  {"proyecto": "C RICO", "constructora": "C RICO"},
  {"proyecto": "OBRAS ESPECIALES", "constructora": "OBRAS ESPECIALES"},
];
