package Documento;

public class Letter extends Documento {
    private String _endereço;

    public Letter(String data, String title, String endereco) {
        super(data, title);
        _endereço = endereco;
    }

    public Letter(String data, String endereco) {
        super(data);
        _endereço = endereco;
    }

    public String getEndereco() {
        return this._endereço;
    }

    public void resposta() {
        System.out.println("Foi respondido.");
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Letter) {
            Letter letter = (Letter) o;
            return this.getEndereco() == letter.getEndereco();
        }
        return false;
    }

    @Override
    public String toString() {
        return this.getTitle() + " - " + this.getEndereco();
    }
}
