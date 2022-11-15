package Cat;

public class App {
    public static void main(String[] args) {
        CatRegistry registry = new CatRegistry();
        Cat tareco = new Cat();
        try {
            registry.put(tareco);
            System.out.println("One Tareco registered.");
            registry.put(new Cat("Tareco", 2));
            System.out.println("Hopefully still just one Tareco registered."); // This shouldn't be executed
        } catch (DuplicateCatException e) {
            System.out.println("------ SOMETHING EXPLODED ------------------------------------");
            e.printStackTrace();
            System.out.println("--------------------------------------------------------------");
        }
        try {
            Cat c = registry.get("Tareco");
            System.out.println(c); // Prints (Tareco, 42), since it exploded instead of inserting (Tareco, 2)
            registry.get("Simba");
        } catch (NoSuchCatException e) {
            System.out.println("------ SOMETHING EXPLODED ------------------------------------");
            e.printStackTrace();
            System.out.println("--------------------------------------------------------------");

        }

        System.out.println("Still Alive");
    }
}