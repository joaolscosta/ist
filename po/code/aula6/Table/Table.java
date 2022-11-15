
public class Table {
    private int[] _vetor;

    public class ForwardIterator implements Iterator {
        private int _index = 0;

        public boolean hasNext() {
            return _index < _vetor.length;
        }

        public int next() {
            return _vetor[_index++];
        }
    }

    public class ReverseIterator implements Iterator {
        private int _index = _vetor.length - 1;

        public boolean hasNext() {
            return _index >= 0;
        }

        public int next() {
            return _vetor[_index--];
        }
    }

    public Table(int size) {
        _vetor = new int[size];
    }

    public void setValue(int pos, int value) {
        _vetor[pos] = value;
    }

    public void setAll(int value) {
        for (int i = 0; i < _vetor.length; i++) {
            _vetor[i] = value;
        }
    }

    public int getValue(int pos) {
        return _vetor[pos];
    }

    public Iterator getForwardIterator() {
        return new ForwardIterator();
    }

    public Iterator getReverseIterator() {
        return new ReverseIterator();
    }

    public class Table(){

    }

}