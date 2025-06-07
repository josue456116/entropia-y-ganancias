package proyecto.arbol;

public class Nodo {
    String valor;
    Nodo izquierda, derecha;

    public Nodo(String valor) {
        this.valor = valor;
        izquierda = derecha = null;
    }
}
