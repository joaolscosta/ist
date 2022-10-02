public class TopCar extends MidCar {
    public TopCar(Engine Engine) {
        super(Engine);
        // TODO Auto-generated constructor stub
    }

    private Xtreme _xtreme;

    @Override
    public void go() {
        super.go();
        _xtreme.on();
    }

    @Override
    public void off() {
        super.stop();
        _xtreme.off();
    }

    public void addXtreme(Xtreme engine) {
        _xtreme = engine;
    }
}
