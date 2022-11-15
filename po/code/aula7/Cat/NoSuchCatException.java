package Cat;

public class NoSuchCatException extends Exception {
    public NoSuchCatException() {
        super("Cat not in registry");
    }
}