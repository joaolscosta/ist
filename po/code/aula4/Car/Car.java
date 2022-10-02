public class Car {
    private Engine _engine;

    public Car(Engine Engine) {
        _engine = new Engine();
    }

    public void go() {
        this._engine.on();
    }

    public void stop() {
        this._engine.off();
    }

    public Engine getEngine() {
        return this._engine;
    }

    public void setEngine(Engine engine) {
        this._engine = engine;
    }

}