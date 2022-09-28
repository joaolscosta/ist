package and_bin;

public class AndGate2 {
    private boolean _a = false;
    private boolean _b = false;

    public AndGate2() {
    }

    public AndGate2(boolean value) {
        _a = value;
        _b = value;
    }

    public AndGate2(boolean v1, boolean v2) {
        _a = v1;
        _b = v2;
    }

    public boolean getOutput() {
        return _a && _b;
    }

    @Override
    public boolean equals(Object other) {
        if (other instanceof AndGate2) {
            AndGate2 andGate = (AndGate2) other;
            return _a == andGate._a && _b == andGate._b;
        }
        return _a;
    }

    @Override
    public String toString() {
        return "A: " + _a + " B: " + _b;
    }
}
