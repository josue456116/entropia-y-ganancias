package proyecto.arbol.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

public class PrediccionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Cargar dataset ARFF desde ruta /WEB-INF/datos.arff
            String path = getServletContext().getRealPath("/WEB-INF/enfermedades.arff");
            DataSource source = new DataSource(path);
            Instances data = source.getDataSet();

            // Establecer la clase si no está definida
            if (data.classIndex() == -1) {
                data.setClassIndex(data.numAttributes() - 1);
            }

            // Crear y entrenar el árbol J48
            J48 arbol = new J48();
            arbol.buildClassifier(data);

            // Obtener el árbol en texto
            String arbolTexto = arbol.toString();

            // Generar código DOT para el árbol
            String dotGraph = generarDot(arbol);

            // Pasar atributos a JSP
            request.setAttribute("arbolTexto", arbolTexto);
            request.setAttribute("arbolGraph", dotGraph);

            // Forward a JSP resultado
            request.getRequestDispatcher("/resultado.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error al generar el árbol de decisión", e);
        }
    }

    private String generarDot(J48 arbol) throws Exception {
        // Weka no tiene método directo para DOT, pero podemos usar el método graph()
        // que devuelve una representación en formato DOT, solo que puede necesitar limpieza.
        return arbol.graph();
    }
}
