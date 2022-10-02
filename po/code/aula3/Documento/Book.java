package Documento;

public class Book extends Documento {
    private String _autor;

    public Book(String title, String data, String autor) {
        super(title, data);
        _autor = autor;
    }

    public Book(String data, String autor) {
        super(data);
        _autor = autor;
    }

    public String getAutor() {
        return this._autor;
    }

    public void crit() {
        System.out.println("O livro " + this.getTitle() + "foi criticado.");
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Book) {
            Book book = (Book) o;
            return this.getAutor() == book.getAutor();
        }
        return false;
    }

    @Override
    public String toString() {
        return this.getAutor() + " - " + this.getTitle();
    }
}
