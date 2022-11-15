import javax.xml.crypto.dsig.Transform;

public class Table {
    private int _vector[];

    public Table(int size) {
        _vector = new int[size];
    }

    public void print(Transform t) {
        for (int i: _vector){
            System.out.println(t.transform(i));
        }
    }
