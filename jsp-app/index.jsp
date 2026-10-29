
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Contacto</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <main class="contenedor">
        <h1>Registro de Contacto</h1>
        <p>Completa los datos para registrar un contacto.</p>

        <form action="registro.jsp" method="post">
            <label for="nombre">Nombre completo</label>
            <input type="text" id="nombre" name="nombre"
                   maxlength="100" required>

            <label for="correo">Correo electrónico</label>
            <input type="email" id="correo" name="correo"
                   maxlength="254" required>

            <label for="telefono">Teléfono</label>
            <input type="tel" id="telefono" name="telefono"
                   pattern="[0-9]{9}" maxlength="9"
                   title="Ingresa 9 dígitos" required>

            <label for="mensaje">Mensaje</label>
            <textarea id="mensaje" name="mensaje"
                      maxlength="500" required></textarea>

            <button type="submit">Registrar contacto</button>
        </form>
    </main>
</body>
</html>
