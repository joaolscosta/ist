package and_bin;

public class AndGate3 extends AndGate2 {
    private boolean _c = false;

    public AndGate3() {
    }

    public AndGate3(boolean value) {
        super(value);
        _c = value;
    }

    public AndGate3(boolean a, boolean b, boolean c) {
        super(a, b);
        _c = c;
    }

    @Override
    public boolean getOutput() {
        return super.getOutput() && _c;
    }

    @Override
    public boolean equals(Object other) {
        if (other instanceof AndGate3) {
            AndGate3 andGate = (AndGate3) other;
            return super.equals(other) && _c == andGate._c;
        }
        return false;
    }

    @Override
    @SuppressWarnings("nls")
    public String toString() {
        return super.toString() + " C:" + _c;
    }
}
