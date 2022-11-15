import java.util.Map;
import java.util.TreeMap;

public class CatRegistry {
    private Map<String, Cat> _cats;

    public CatRegistry() {
        _cats = new TreeMap<String, Cat>();
    }

    public Cat get(String nome) throws NoSuchCatException {
        Cat cat = _cats.get(name);
        if (cat == null) {
            throw new NoSuchCatException();
        }
        return cat;
    }

    public void put(Cat cat) throws NoCatException {
        if (_cats.get(cat.getName()) != null) {
            throw new DuplicateCatException();
        }
        _cats.put(cat.getName(), cat);
    }
}