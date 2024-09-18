#!/bin/bash

INVENTARIO="inventario.txt"

# Función para mostrar el menú de ayuda
mostrar_ayuda() {
  echo "Gestión de Inventario - Opciones:"
  echo "1. Agregar Producto"
  echo "2. Listar Productos"
  echo "3. Buscar Producto"
  echo "4. Ordenar Productos por Precio"
  echo "5. Salir"
  echo "--help o -h: Mostrar este mensaje de ayuda."
}

# Función para agregar un producto
agregar_producto() {
  echo "Agregar un nuevo producto:"
  read -p "Nombre del producto: " nombre
  read -p "Precio del producto: " precio
  read -p "Cantidad del producto: " cantidad
  
  # Validar que el precio y la cantidad sean numéricos
  if ! [[ "$precio" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: El precio debe ser un número válido."
    return
  fi
  
  if ! [[ "$cantidad" =~ ^[0-9]+$ ]]; then
    echo "Error: La cantidad debe ser un número entero."
    return
  fi
  
  # Añadir el producto al archivo de inventario
  echo "$nombre,$precio,$cantidad" >> "$INVENTARIO"
  echo "Producto agregado correctamente."
}

# Función para listar todos los productos
listar_productos() {
  if [[ ! -s "$INVENTARIO" ]]; then
    echo "El inventario está vacío."
    return
  fi
  
  echo "Listado de productos:"
  cat "$INVENTARIO"
}

# Función para buscar un producto por nombre
buscar_producto() {
  read -p "Ingrese el nombre del producto a buscar: " nombre
  
  resultado=$(grep -i "^$nombre," "$INVENTARIO")
  
  if [[ -z "$resultado" ]]; then
    echo "Producto no encontrado."
  else
    echo "Producto encontrado:"
    echo "$resultado"
  fi
}

# Función para ordenar los productos por precio
ordenar_por_precio() {
  if [[ ! -s "$INVENTARIO" ]]; then
    echo "El inventario está vacío."
    return
  fi
  
  echo "Productos ordenados por precio:"
  sort -t',' -k2 -n "$INVENTARIO"
}

# Función principal para mostrar el menú
menu() {
  while true; do
    echo -e "\nGestión de Inventario"
    echo "1. Agregar Producto"
    echo "2. Listar Productos"
    echo "3. Buscar Producto"
    echo "4. Ordenar Productos por Precio"
    echo "5. Salir"
    read -p "Seleccione una opción: " opcion
    
    case $opcion in
      1) agregar_producto ;;
      2) listar_productos ;;
      3) buscar_producto ;;
      4) ordenar_por_precio ;;
      5) echo "Saliendo..."; exit 0 ;;
      *) echo "Opción no válida." ;;
    esac
  done
}

# Si se pasa --help o -h como parámetro, mostrar ayuda
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  mostrar_ayuda
else
  # Ejecutar el menú principal
  menu
fi
