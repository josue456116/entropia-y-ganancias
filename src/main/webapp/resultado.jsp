<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Árbol de Diagnóstico Médico</title>
    <script src="https://cdn.jsdelivr.net/npm/viz.js@2.1.2/viz.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/viz.js@2.1.2/full.render.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

        /* Reset básico */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: linear-gradient(135deg, #e0f2f1, #80cbc4);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
            color: #263238;
            user-select: none;
        }

        h1 {
            font-weight: 700;
            font-size: 2.8rem;
            color: #004d40;
            margin-bottom: 30px;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.15);
            text-align: center;
        }

        /* Contenedor principal que divide la pantalla en dos columnas */
        .contenedor-arboles {
            display: flex;
            justify-content: center;
            gap: 40px;
            width: 100%;
            max-width: 1200px;
            flex-wrap: wrap;
        }

        /* Estilos para ambos contenedores (texto y gráfico) */
        .arbol-texto, .arbol-grafico {
            background: #ffffffdd;
            border-radius: 16px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            padding: 30px 40px;
            flex: 1 1 500px; /* crecer, reducir y base */
            min-width: 320px;
            max-height: 80vh;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        /* Título en cada sección */
        .arbol-texto h2,
        .arbol-grafico h2 {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: #00796b;
            border-bottom: 2px solid #004d40;
            padding-bottom: 8px;
            user-select: text;
        }

        /* Contenido de texto - estilo tipo código */
        pre {
            background-color: #263238;
            color: #a5d6a7;
            padding: 20px;
            border-radius: 12px;
            font-family: 'Source Code Pro', monospace, monospace;
            font-size: 0.95rem;
            white-space: pre-wrap;
            overflow-wrap: break-word;
            overflow-x: auto;
            flex-grow: 1;
            box-shadow: inset 0 0 10px #004d40aa;
        }

        /* Contenedor del gráfico centrado */
        #grafico {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 400px;
            background: #e0f7fa;
            border-radius: 12px;
            box-shadow: inset 0 0 15px #004d4088;
            user-select: none;
            position: relative;
        }

        /* Texto de carga y error */
        #grafico.loading::after {
            content: "Cargando visualización del árbol de decisión...";
            color: #004d40;
            font-weight: 600;
            font-size: 1rem;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            user-select: none;
        }

        #grafico.error::after {
            content: "Error al generar el gráfico.";
            color: #d32f2f;
            font-weight: 700;
            font-size: 1.1rem;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            user-select: none;
        }

        /* Scrollbar personalizado para Chrome, Edge y Firefox */
        .arbol-texto pre::-webkit-scrollbar,
        .arbol-grafico::-webkit-scrollbar {
            width: 12px;
        }
        .arbol-texto pre::-webkit-scrollbar-track,
        .arbol-grafico::-webkit-scrollbar-track {
            background: #c8e6c9aa;
            border-radius: 12px;
        }
        .arbol-texto pre::-webkit-scrollbar-thumb {
            background: #00796b;
            border-radius: 12px;
        }
        .arbol-texto pre {
            scrollbar-width: thin;
            scrollbar-color: #00796b #c8e6c9aa;
        }

        /* Responsive para pantallas pequeñas */
        @media (max-width: 850px) {
            .contenedor-arboles {
                flex-direction: column;
                gap: 30px;
            }
            .arbol-texto, .arbol-grafico {
                max-height: none;
                min-width: 100%;
            }
            h1 {
                font-size: 2.2rem;
            }
        }
    </style>
</head>
<body>
    <h1>Árbol de Diagnóstico Médico (J48)</h1>

    <div class="contenedor-arboles">
        <section class="arbol-texto">
            <h2>Diagnóstico en Texto</h2>
            <pre>
<%= request.getAttribute("arbolTexto") != null ? request.getAttribute("arbolTexto") : "No se generó ningún árbol" %>
            </pre>
        </section>

        <section class="arbol-grafico">
            <h2>Visualización del Árbol</h2>
            <div id="grafico" class="loading"></div>
        </section>
    </div>

<%
    String dot = (String) request.getAttribute("arbolGraph");
    if (dot == null) {
        dot = "";
    } else {
        dot = dot.replace("\\", "\\\\")
                 .replace("\"", "\\\"")
                 .replace("\r", "")
                 .replace("\n", "\\n");
    }
%>

<script>
    const dotCode = "<%= dot %>";
    const grafico = document.getElementById("grafico");

    if (dotCode.trim().length > 0) {
        const viz = new Viz();
        viz.renderSVGElement(dotCode)
            .then(element => {
                grafico.classList.remove("loading", "error");
                grafico.innerHTML = "";
                grafico.appendChild(element);
            })
            .catch(error => {
                grafico.classList.remove("loading");
                grafico.classList.add("error");
                console.error("Error al generar gráfico:", error);
            });
    } else {
        grafico.classList.remove("loading");
        grafico.innerText = "No se proporcionó un gráfico para mostrar.";
    }
</script>
</body>
</html>
