package Animal;

import Animal;

public class Cat extends Animal {
    private int _lifes;

    public Cat(String name, int age, int lifes) {
        super(name, age);
        _lifes = lifes;
    }

    public Cat(int age, int lifes) {
        super(age);
        
    }
}
