package Animal;

public class Cat extends Animal {
    private int _lifes;

    public Cat(String name, int age, int lifes) {
        super(name, age);
        _lifes = lifes;
    }

    public Cat(int age, int lifes) {
        super(age);
        _lifes = lifes;
    }

    public int getLifes() {
        return this._lifes;
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Cat) {
            Cat cat = (Cat) o;
            return this.getName() == cat.getName() && this.getAge() == cat.getAge();
        }
        return false;
    }

    @Override
    public String toString() {
        return this.getName() + " - " + this.getAge();
    }
}
