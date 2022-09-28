package Animal;

public class Dog extends Animal {
    private double _weight;

    public Dog(String name, int age, double weight) {
        super(name, age);
        _weight = weight;
    }

    public Dog(int age, double weight) {
        super(age);
        _weight = weight;
    }

    public double getWeight() {
        return this._weight;
    }

    public String bark() {
        return this.getName() + "is barking.";
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Dog) {
            Dog dog = (Dog) o;
            return this.getName() == dog.getName() &&
                    this.getAge() == dog.getWeight();
        }
        return false;
    }

    @Override
    public String toString() {
        return this.getName() + "has " + this._weight + "kg";
    }
}
