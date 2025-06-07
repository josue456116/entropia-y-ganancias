<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Sistema de Diagnóstico Médico</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

        /* Reset básico */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            font-family: 'Inter', Arial, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: #f0f0f0;
            user-select: none;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
        }

        main {
            background: #ffffff;
            color: #333;
            padding: 50px 60px;
            border-radius: 25px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            max-width: 460px;
            width: 100%;
            user-select: text;
        }

        h1 {
            font-weight: 700;
            font-size: 2.8rem;
            margin-bottom: 40px;
            color: #2a5298;
            text-shadow: 1px 1px 3px rgba(42,82,152,0.4);
        }

        p.instruction {
            font-size: 1.15rem;
            margin-bottom: 35px;
            color: #555555;
        }

        button {
            background: linear-gradient(90deg, #0052cc 0%, #0041a8 100%);
            border: none;
            border-radius: 14px;
            padding: 18px 50px;
            font-size: 1.3rem;
            font-weight: 600;
            color: white;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(0,82,204,0.6);
            transition: background 0.4s ease, transform 0.2s ease, box-shadow 0.4s ease;
            user-select: none;
            letter-spacing: 0.03em;
        }

        button:hover {
            background: linear-gradient(90deg, #0041a8 0%, #003580 100%);
            transform: scale(1.05);
            box-shadow: 0 8px 30px rgba(0,82,204,0.85);
        }

        button:focus {
            outline: none;
            box-shadow: 0 0 0 4px rgba(0,82,204,0.5), 0 8px 30px rgba(0,82,204,0.85);
        }

        /* Texto pequeño debajo del botón */
        form::after {
            content: "Haz clic para generar el árbol de decisión";
            display: block;
            margin-top: 22px;
            font-size: 0.9rem;
            color: #777777;
            opacity: 0.8;
            user-select: none;
            font-style: italic;
        }

        /* Responsive */
        @media (max-width: 500px) {
            main {
                padding: 40px 30px;
            }
            h1 {
                font-size: 2.2rem;
                margin-bottom: 30px;
            }
            p.instruction {
                font-size: 1rem;
                margin-bottom: 25px;
            }
            button {
                padding: 14px 35px;
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
    <main>
        <h1>Sistema de Diagnóstico Médico</h1>
        <form action="PrediccionServlet" method="get">
            <p class="instruction">Presiona el botón para iniciar el proceso y generar el árbol de decisión.</p>
            <button type="submit">Generar Árbol de Decisión</button>
        </form>
    </main>
</body>
</html>
