package Animal;

public class Animal {
    private String _name;
    private int _age;

    public Animal(String name, int age) {
        _name = name;
        _age = age;
    }

    public Animal(int age) {
        _name = "Belchior";
        _age = age;
    }

    public String getName() {
        return this._name;
    }

    public int getAge() {
        return this._age;
    }

    public String sleep() {
        return this._name + "is sleeping.";
    }
}