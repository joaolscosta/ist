package Documento;

import javax.print.Doc;

public class Documento {
    private String _data;
    private String _title;

    public Documento(String data, String titulo) {
        _data = data;
        _title = titulo;
    }

    public Documento(String data) {
        _data = data;
        _title = "";
    }

    public String getData() {
        return this._data;
    }

    public String getTitle() {
        return this._title;
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Documento) {
            Documento doc = (Documento) o;
            return this.getTitle() == doc.getTitle() && this.getData() == doc.getData();
        }
        return false;
    }

    @Override
    public String toString() {
        return this._title + " - " + this._data;
    }
}
