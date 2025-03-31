#!/bin/bash

# Verificar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Usa 'sudo'."
    exit 1
fi

# Preguntar por el nombre del departamento
read -p "Ingrese el nombre del departamento: " departamento

# Crear el grupo del departamento
if grep -q "^${departamento}:" /etc/group; then
    echo "El grupo $departamento ya existe."
else
    groupadd "$departamento"
    echo "Grupo $departamento creado exitosamente."
fi

# Preguntar por el prefijo de los usuarios
read -p "Qué prefijo desea usar para los usuarios? (ej. 'user'): " prefijo

# Preguntar por el número de usuarios
read -p "Cuántos usuarios desea crear? " cantidad_usuarios

# Preguntar por la contraseña
read -p "Ingrese la contraseña para los usuarios (presione Enter para usar '1234'): " password

# Establecer contraseña por defecto si no se especifica
if [ -z "$password" ]; then
    password="1234"
    echo "Se usará la contraseña por defecto: 1234"
fi

# Crear los usuarios
for ((i=1; i<=$cantidad_usuarios; i++))
do
    username="${prefijo}${i}"
    
    # Verificar si el usuario ya existe
    if id "$username" &>/dev/null; then
        echo "El usuario $username ya existe. Se omitirá."
        continue
    fi
    
    # Crear el usuario
    useradd -m -g "$departamento" -s /bin/bash "$username"
    echo "$username:$password" | chpasswd
    
    # Forzar cambio de contraseña en primer login
    chage -d 0 "$username"
    
    echo "Usuario $username creado en el departamento $departamento."
done

echo "Proceso completado. Se crearon $cantidad_usuarios usuarios en el departamento $departamento."