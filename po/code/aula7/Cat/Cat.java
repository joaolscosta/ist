package Cat;

public class Cat {
    String _name = "Tareco";
    int _age = 42;

    public Cat() {
    }

    public Cat(String name, int age) {

    }

    public String getName() {
        return _name;
    }

    public int getAge() {
        return _age;
    }

    public void setName(String name) {
        _name = name;
    }

    public void setAge(int age) {
        _age = age;
    }

    @Override
    public String toString() {
        return "(" + _name + ", " + _age + ")";
    }
}