
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.util.regex.Pattern,javax.servlet.http.HttpServletResponse" %>
<%!
    private String escapar(String texto) {
        if (texto == null) return "";
        return texto.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setHeader("Allow", "POST");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED,
                           "Solo se permite el metodo POST.");
        return;
    }

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String telefono = request.getParameter("telefono");
    String mensaje = request.getParameter("mensaje");

    nombre = nombre == null ? "" : nombre.trim();
    correo = correo == null ? "" : correo.trim();
    telefono = telefono == null ? "" : telefono.trim();
    mensaje = mensaje == null ? "" : mensaje.trim();

    boolean valido =
        !nombre.isEmpty() && nombre.length() <= 100 &&
        !mensaje.isEmpty() && mensaje.length() <= 500 &&
        correo.length() <= 254 &&
        Pattern.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", correo) &&
        Pattern.matches("^[0-9]{9}$", telefono);

    if (!valido) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    } else {
        List<Map<String, String>> contactos =
            (List<Map<String, String>>) session.getAttribute("contactos");

        if (contactos == null) {
            contactos = new ArrayList<Map<String, String>>();
            session.setAttribute("contactos", contactos);
        }

        Map<String, String> contacto = new LinkedHashMap<String, String>();
        contacto.put("nombre", nombre);
        contacto.put("correo", correo);
        contacto.put("telefono", telefono);
        contacto.put("mensaje", mensaje);
        contactos.add(contacto);
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado del registro</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
<main class="contenedor">
    <% if (!valido) { %>
        <h1>Error de validación</h1>
        <p>Verifica los campos. El correo debe ser válido y el
           teléfono debe contener 9 dígitos.</p>
        <a href="index.jsp">Volver al formulario</a>
    <% } else { %>
        <h1>Contactos registrados</h1>
        <p>El contacto se registró correctamente.</p>

        <div class="tabla-contenedor">
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Mensaje</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Map<String, String>> lista =
                    (List<Map<String, String>>) session.getAttribute("contactos");

                for (Map<String, String> c : lista) {
            %>
                <tr>
                    <td><%= escapar(c.get("nombre")) %></td>
                    <td><%= escapar(c.get("correo")) %></td>
                    <td><%= escapar(c.get("telefono")) %></td>
                    <td><%= escapar(c.get("mensaje")) %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <a href="index.jsp">Registrar otro contacto</a>
    <% } %>
</main>
</body>
</html>
