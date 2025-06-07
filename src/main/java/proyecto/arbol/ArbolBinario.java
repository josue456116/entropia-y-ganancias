package proyecto.arbol;

public class ArbolBinario {
    private Nodo raiz;

    public void insertar(String valor) {
        raiz = insertarRecursivo(raiz, valor);
    }

    private Nodo insertarRecursivo(Nodo nodo, String valor) {
        if (nodo == null) {
            return new Nodo(valor);
        }
        if (valor.compareTo(nodo.valor) < 0) {
            nodo.izquierda = insertarRecursivo(nodo.izquierda, valor);
        } else {
            nodo.derecha = insertarRecursivo(nodo.derecha, valor);
        }
        return nodo;
    }

    public void inorden(Nodo nodo, StringBuilder sb) {
        if (nodo != null) {
            inorden(nodo.izquierda, sb);
            sb.append(nodo.valor).append(" ");
            inorden(nodo.derecha, sb);
        }
    }

    public void preorden(Nodo nodo, StringBuilder sb) {
        if (nodo != null) {
            sb.append(nodo.valor).append(" ");
            preorden(nodo.izquierda, sb);
            preorden(nodo.derecha, sb);
        }
    }

    public void postorden(Nodo nodo, StringBuilder sb) {
        if (nodo != null) {
            postorden(nodo.izquierda, sb);
            postorden(nodo.derecha, sb);
            sb.append(nodo.valor).append(" ");
        }
    }

    public String recorridoInorden() {
        StringBuilder sb = new StringBuilder();
        inorden(raiz, sb);
        return sb.toString().trim();
    }

    public String recorridoPreorden() {
        StringBuilder sb = new StringBuilder();
        preorden(raiz, sb);
        return sb.toString().trim();
    }

    public String recorridoPostorden() {
        StringBuilder sb = new StringBuilder();
        postorden(raiz, sb);
        return sb.toString().trim();
    }

    public Nodo getRaiz() {
        return raiz;
    }
}
